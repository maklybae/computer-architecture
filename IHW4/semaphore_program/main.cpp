#include <getopt.h>
#include <omp.h>

#include <cassert>
#include <chrono>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <random>
#include <string>
#include <vector>

std::mt19937 rnd(52);  // Для разработки используется детерминированный рандом

int WIDTH = 5;
int HEIGHT = 5;
int SHOT_PRICE = 1;
bool FILE_OUTPUT = false;

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

State state;
std::ofstream outputFileStream;

// Вывод карты
void printMap(const std::vector<bool>& map, const std::string& name) {
  std::cout << "Карта государства " << name << ":\n";
  if (FILE_OUTPUT) {
    outputFileStream << "Карта государства " << name << ":\n";
  }
  for (int i = 0; i < WIDTH * HEIGHT; ++i) {
    std::cout << (map[i] ? 'X' : '.') << ' ';
    if (FILE_OUTPUT) {
      outputFileStream << (map[i] ? 'X' : '.') << ' ';
    }
    if (i % WIDTH == WIDTH - 1) {
      std::cout << '\n';
      if (FILE_OUTPUT) {
        outputFileStream << '\n';
      }
    }
  }
}

void anchuariaTurnFunction() {
  // Выбор случайной точки удара
  int pos = rnd() % (WIDTH * HEIGHT);
  state.anchuariaShots++;

  if (!state.taranteriaMapDamage[pos]) {
    state.taranteriaMapDamage[pos] = true;
    state.taranteriaMapRestSum -= state.taranteriaMapPrice[pos];
    std::cout << "Анчуария попала в точку (" << pos / WIDTH << ", " << pos % WIDTH << ")!\n";
    if (FILE_OUTPUT) {
      outputFileStream << "Анчуария попала в точку (" << pos / WIDTH << ", " << pos % WIDTH << ")!\n";
    }
  } else {
    std::cout << "Анчуария промахнулась!\n";
    if (FILE_OUTPUT) {
      outputFileStream << "Анчуария промахнулась!\n";
    }
  }

  // Проверка окончания войны, условия того, что государство-поток проиграло
  if (state.taranteriaMapRestSum == 0 || state.anchuariaShots * SHOT_PRICE > state.taranteriaMapRestSum) {
    state.gameOver = true;
  }

  // Вывод
  printMap(state.taranteriaMapDamage, "Тарантерия");
  std::cout << "Оставшаяся сумма на карте противника: " << state.taranteriaMapRestSum << '\n';
  std::cout << "Потраченная на снаряды сумма: " << state.anchuariaShots * SHOT_PRICE << '\n';
  std::cout << std::endl;  // flush
  if (FILE_OUTPUT) {
    outputFileStream << "Оставшаяся сумма на карте противника: " << state.taranteriaMapRestSum << '\n';
    outputFileStream << "Потраченная на снаряды сумма: " << state.anchuariaShots * SHOT_PRICE << '\n';
    outputFileStream << std::endl;  // flush
  }
}

void taranteriaTurnFunction() {
  // Выбор случайной точки удара
  int pos = rnd() % (WIDTH * HEIGHT);
  state.taranteriaShots++;

  if (!state.anchuariaMapDamage[pos]) {
    state.anchuariaMapDamage[pos] = true;
    state.anchuariaMapRestSum -= state.anchuariaMapPrice[pos];
    std::cout << "Тарантерия попала в точку (" << pos / WIDTH << ", " << pos % WIDTH << ")!\n";
    if (FILE_OUTPUT) {
      outputFileStream << "Тарантерия попала в точку (" << pos / WIDTH << ", " << pos % WIDTH << ")!\n";
    }
  } else {
    std::cout << "Тарантерия промахнулась!" << '\n';
    if (FILE_OUTPUT) {
      outputFileStream << "Тарантерия промахнулась!" << '\n';
    }
  }

  // Проверка окончания войны, условия того, что государство-поток проиграло
  if (state.anchuariaMapRestSum == 0 || state.taranteriaShots * SHOT_PRICE > state.anchuariaMapRestSum) {
    state.gameOver = true;
  }

  // Вывод
  printMap(state.anchuariaMapDamage, "Анчуария");
  std::cout << "Оставшаяся сумма на карте противника: " << state.anchuariaMapRestSum << '\n';
  std::cout << "Потраченная на снаряды сумма: " << state.taranteriaShots * SHOT_PRICE << '\n';
  std::cout << std::endl;  // flush
  if (FILE_OUTPUT) {
    outputFileStream << "Оставшаяся сумма на карте противника: " << state.anchuariaMapRestSum << '\n';
    outputFileStream << "Потраченная на снаряды сумма: " << state.taranteriaShots * SHOT_PRICE << '\n';
    outputFileStream << std::endl;  // flush
  }
}

void setupParams(int argc, char* argv[]) {
  int opt;
  std::string filePath;
  std::string outputFilePath;
  bool fileProvided = false;

  while ((opt = getopt(argc, argv, "x:y:c:f:o:")) != -1) {
    switch (opt) {
      case 'x':
        WIDTH = atoi(optarg);
        assert(WIDTH >= 1 && "Ширина поля должна быть как минимум 1");
        break;
      case 'y':
        HEIGHT = atoi(optarg);
        assert(HEIGHT >= 1 && "Высота поля должна быть как минимум 1");
        break;
      case 'c':
        SHOT_PRICE = atoi(optarg);
        assert(SHOT_PRICE >= 1 && "Стоимость снаряда как минимум 1");
        break;
      case 'f':
        filePath = optarg;
        fileProvided = true;
        break;
      case 'o':
        FILE_OUTPUT = true;
        outputFilePath = optarg;  // Сохраняем путь к выходному файлу
        break;
      default:
        std::cerr << "Usage: " << argv[0]
                  << " [-x <width>] [-y <height>] [-c <shot_price>] [-f <input_file>] [-o <output_file>]\n";
        exit(1);
    }
  }

  // Чтение из файла
  if (fileProvided) {
    std::ifstream inputFile{filePath};
    if (!inputFile.is_open()) {
      std::cerr << "Не удалось открыть файл " << filePath << std::endl;
      exit(1);
    }

    // Считываем данные из файла: WIDTH, HEIGHT, SHOT_PRICE
    if (!(inputFile >> WIDTH >> HEIGHT >> SHOT_PRICE)) {
      std::cerr << "Неверный формат данных в файле" << std::endl;
      exit(1);
    }

    // Проверяем ограничения после чтения
    assert(WIDTH >= 1 && "Ширина поля должна быть как минимум 1");
    assert(HEIGHT >= 1 && "Высота поля должна быть как минимум 1");
    assert(SHOT_PRICE >= 1 && "Стоимость снаряда как минимум 1");

    inputFile.close();
  }

  if (FILE_OUTPUT) {
    outputFileStream = std::ofstream(outputFilePath);
    if (!outputFileStream.is_open()) {
      std::cerr << "Не удалось открыть файл " << outputFilePath << std::endl;
      exit(1);
    }
  }
}

int main(int argc, char* argv[]) {
  // Ввод переменных
  setupParams(argc, argv);

  // Инициализация
  state.anchuariaMapDamage = std::vector<bool>(WIDTH * HEIGHT, false);
  state.anchuariaMapPrice = std::vector<int>(WIDTH * HEIGHT);
  for (int i = 0; i < WIDTH * HEIGHT; ++i) {
    state.anchuariaMapPrice[i] = rnd() % 10 + 1;
    state.anchuariaMapRestSum += state.anchuariaMapPrice[i];
  }

  state.taranteriaMapDamage = std::vector<bool>(WIDTH * HEIGHT, 0);
  state.taranteriaMapPrice = std::vector<int>(WIDTH * HEIGHT);
  for (int i = 0; i < WIDTH * HEIGHT; ++i) {
    state.taranteriaMapPrice[i] = rnd() % 10 + 1;
    state.taranteriaMapRestSum += state.taranteriaMapPrice[i];
  }

// Параллельная работа потоков с OpenMP
#pragma omp parallel sections
  {
#pragma omp section
    {
      while (!state.gameOver) {
        anchuariaTurnFunction();
      }
    }
#pragma omp section
    {
      while (!state.gameOver) {
        taranteriaTurnFunction();
      }
    }
  }

  std::cout << "Война закончилась!";
  if (FILE_OUTPUT) {
    outputFileStream << "Война закончилась!";
  }

  // Очистка ресурсов
  if (FILE_OUTPUT) {
    outputFileStream.close();
  }
  return 0;
}
