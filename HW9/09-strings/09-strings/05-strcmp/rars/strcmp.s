# Моделирование функции strlen(asciiz_string) в RARS
.eqv     BUF_SIZE 10
    .data
buf1:    .space BUF_SIZE     # Буфер для первой строки
buf2:    .space BUF_SIZE     # Буфер для второй строки
empty_test_str: .asciz ""   # Пустая тестовая строка
short_test_str: .asciz "Hello!"     # Короткая тестовая строка
long_test_str:  .asciz "I am long for BUF_SIZE" # Длинная тестовая строка

    .text
strcmp:
loop:
    lb      t0 (a0)     # Загрузка символа из 1-й строки для сравнения
    lb      t1 (a1)     # Загрузка символа из 2-й строки для сравнения
    beqz    t0 end      # Конец строки 1
    beqz    t1 end      # Конец строки 2
    bne     t0 t1 end   # Выход по неравенству
    addi    a0 a0 1     # Адрес символа в строке 1 увеличивается на 1
    addi    a1 a1 1     # Адрес символа в строке 2 увеличивается на 1
    b       loop
end:
    sub     a0 t0 t1    # Получение разности между символами
    ret

.globl main
main:
    # Ввод строки 1 в буфер
    la      a0 buf1
    li      a1 BUF_SIZE
    li      a7 8
    ecall
    # Тестовый вывод строки 1
    la      a0 buf1
    li      a7 4
    ecall
    # Ввод строки 2 в буфер
    la      a0 buf2
    li      a1 BUF_SIZE
    li      a7 8
    ecall
    # Тестовый вывод строки 2
    la      a0 buf2
    li      a7 4
    ecall
    # Сравнение строк в буферах
    la      a0 buf1
    la      a1 buf2
    jal     strcmp
    # Вывод результата сравнения
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Сравнение с пустой строкой
    la      a0 empty_test_str
    la      a1 short_test_str
    jal     strcmp
    # Вывод результата сравнения
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Сравнение короткой строки с собой
    la      a0 short_test_str
    la      a1 short_test_str
    jal     strcmp
    # Вывод результата сравнения
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Сравнение длинной	строки с короткой
    la      a0 long_test_str
    la      a1 short_test_str
    jal     strcmp
    # Вывод результата сравнения
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Завершение программы
    li      a7 10
    ecall

