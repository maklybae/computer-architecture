# Моделирование функции strnlen(asciiz_string, max_size) в RARS
.eqv     BUF_SIZE 10
    .data
buf:    .space BUF_SIZE     # Буфер для чтения данных
empty_test_str: .asciz ""   # Пустая тестовая строка
short_test_str: .asciz "Hello!"     # Короткая тестовая строка
long_test_str:  .asciz "I am long for BUF_SIZE" # Длинная тестовая строка

    .text
strnlen:
    li      t0 0        # Счетчик
loop:
    lb      t1 (a0)   # Загрузка символа для сравнения
    beqz    t1 end
    addi    t0 t0 1		# Счетчик символов увеличивается на 1
    addi    a0 a0 1		# Берется следующий символ
    bge     t0 a1 fatal # Выход, по превышению размера буфера
    b       loop
end:
    mv      a0 t0
    ret
fatal:
    li      a0 -1
    ret

.globl main
main:
    # Ввод строки в буфер
    la      a0 buf
    li      a1 BUF_SIZE
    li      a7 8
    ecall
    # Тестовый вывод строки
    la      a0 buf
    li      a7 4
    ecall
    # Вычисление длины для вводимой строки
    la      a0 buf
    li      a1 BUF_SIZE
    jal     strnlen
    # Вывод счетчика
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Вычисление длины для пустой строки
    la      a0 empty_test_str
    li      a1 BUF_SIZE
    jal     strnlen
    # Вывод счетчика
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Вычисление длины для короткой	строки
    la      a0 short_test_str
    li      a1 BUF_SIZE
    jal     strnlen
    # Вывод счетчика
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Вычисление длины для длинной	строки
    la      a0 long_test_str
    li      a1 BUF_SIZE
    jal     strnlen
    # Вывод счетчика
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Завершение программы
    li      a7 10
    ecall

