#include <pthread.h>
#include <unistd.h>  // Для функции sleep

#include <cstdlib>
#include <ctime>
#include <iostream>
#include <vector>

const int WIDTH = 5;   // Размер карты (ширина)
const int HEIGHT = 5;  // Размер карты (высота)
const int SHOT_PRICE = 1;

// Структура состояния
struct State {
  std::vector<bool> anchuariaMapDamage;
  std::vector<int> anchuariaMapPrice;
  int anchuariaMapRestSum = 0;
  int anchuariaShots = 0;
  std::vector<bool> taranteriaMapDamage;
  std::vector<int> taranteriaMapPrice;
  int taranteriaMapRestSum = 0;
  int taranteriaShots = 0;
  bool gameOver = false;
  char currentTurn = 'a';
};

pthread_mutex_t mutex;
pthread_cond_t turnCondition;
State state;

// Вывод карты
void printMap(const std::vector<bool> &map, const std::string &name) {
  std::cout << name << " Map:\n";
  for (int i = 0; i < WIDTH * HEIGHT; ++i) {
    std::cout << (map[i] ? 'X' : '.') << ' ';
    if (i % WIDTH == WIDTH - 1) {
      std::cout << '\n';
    }
  }
}

// Поток Анчуарии
void *anchuaria(void *arg) {
  while (true) {
    pthread_mutex_lock(&mutex);

    // Ждем своей очереди
    // Цикл предотвращает "ложное пробуждение"
    while (state.currentTurn != 'a' && !state.gameOver) {
      pthread_cond_wait(&turnCondition, &mutex);
    }

    if (state.gameOver) {
      pthread_mutex_unlock(&mutex);
      pthread_cond_broadcast(&turnCondition);
      break;
    }

    // Выбор случайной точки удара
    int pos = rand() % (WIDTH * HEIGHT);
    state.anchuariaShots++;

    if (!state.taranteriaMapDamage[pos]) {
      state.taranteriaMapDamage[pos] = true;
      state.taranteriaMapRestSum -= state.taranteriaMapPrice[pos];
      std::cout << "Анчуария попала в точку (" << pos / WIDTH << ", " << pos % WIDTH << ")!\n";
    } else {
      std::cout << "Анчуария промахнулась!\n";
    }

    // Проверка окончания войны
    if (state.taranteriaMapRestSum == 0 || state.anchuariaShots * SHOT_PRICE > state.taranteriaMapRestSum) {
      state.gameOver = true;
    }

    // Вывод карты
    printMap(state.taranteriaMapDamage, "Taranteria");

    // Передаем ход Тарантерии
    state.currentTurn = 't';
    pthread_cond_broadcast(&turnCondition);
    pthread_mutex_unlock(&mutex);

    sleep(1);  // Пауза для наглядности
  }

  return nullptr;
}

// Поток Тарантерии
void taranteria() {
  while (true) {
    pthread_mutex_lock(&mutex);

    // Ждем своей очереди
    // Цикл предотвращает "ложное пробуждение"
    while (state.currentTurn != 't' && !state.gameOver) {
      pthread_cond_wait(&turnCondition, &mutex);
    }

    if (state.gameOver) {
      pthread_mutex_unlock(&mutex);
      pthread_cond_broadcast(&turnCondition);
      break;
    }

    // Выбор случайной точки удара
    int pos = rand() % (WIDTH * HEIGHT);
    state.taranteriaShots++;

    if (!state.anchuariaMapDamage[pos]) {
      state.anchuariaMapDamage[pos] = true;
      state.anchuariaMapRestSum -= state.anchuariaMapPrice[pos];
      std::cout << "Тарантерия попала в точку (" << pos / WIDTH << ", " << pos % WIDTH << ")!\n";
    } else {
      std::cout << "Тарантерия промахнулась!" << '\n';
    }

    // Проверка окончания войны
    if (state.anchuariaMapRestSum == 0 || state.taranteriaShots * SHOT_PRICE > state.anchuariaMapRestSum) {
      state.gameOver = true;
    }

    // Вывод карты
    printMap(state.anchuariaMapDamage, "Anchuaria");

    // Передаем ход Анчуарии
    state.currentTurn = 'a';
    pthread_cond_broadcast(&turnCondition);
    pthread_mutex_unlock(&mutex);

    sleep(1);  // Пауза для наглядности
  }
}

int main() {
  // Инициализация
  pthread_mutex_init(&mutex, nullptr);
  pthread_cond_init(&turnCondition, nullptr);

  state.anchuariaMapDamage = std::vector<bool>(WIDTH * HEIGHT, false);
  state.anchuariaMapPrice = std::vector<int>(WIDTH * HEIGHT);
  for (int i = 0; i < WIDTH * HEIGHT; ++i) {
    state.anchuariaMapPrice[i] = rand() % 10 + 1;
    state.anchuariaMapRestSum += state.anchuariaMapPrice[i];
  }

  state.taranteriaMapDamage = std::vector<bool>(WIDTH * HEIGHT, 0);
  state.taranteriaMapPrice = std::vector<int>(WIDTH * HEIGHT);
  for (int i = 0; i < WIDTH * HEIGHT; ++i) {
    state.taranteriaMapPrice[i] = rand() % 10 + 1;
    state.taranteriaMapRestSum += state.taranteriaMapPrice[i];
  }

  pthread_t anchuariaThread;

  // Запуск потока Анчуарии
  pthread_create(&anchuariaThread, nullptr, anchuaria, nullptr);

  // Основной поток для Тарантерии
  taranteria();

  // Ожидаем завершения потока Анчуарии
  pthread_join(anchuariaThread, nullptr);

  // Очистка ресурсов
  pthread_mutex_destroy(&mutex);
  pthread_cond_destroy(&turnCondition);

  std::cout << "Война закончилась!\n";
  return 0;
}
