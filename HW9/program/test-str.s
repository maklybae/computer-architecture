# Тестирование макроопределений и подпрограмм обработки строк символов
.include "macro-syscalls.m"
.include "macro-string.m"

.eqv     BUF_SIZE 20

.data
buf1:    .space BUF_SIZE     # Буфер для первой строки
.align 2
buf2:    .space BUF_SIZE     # Буфер для второй строки
.align 2
empty_test_str: .asciz "\0\0\0\0\0\0\0\0\0\0"   # Пустая тестовая строка
.align 2
short_test_str: .asciz "Hello!"     # Короткая тестовая строка
.align 2
long_test_str:  .asciz "I am long string" # Длинная тестовая строка
.align 2

    .text
.globl main
main:
    # Ввод строки 2 в буфер
    la      a0 buf2
    li      a1 BUF_SIZE
    li      a7 8
    ecall
    # Тестовый вывод строки 2
    print_str(buf2)


    # Сравнение строк в буферах
    strncpy(buf1, buf2, 4)
    print_str(buf1)
    
    newline

    strncpy(empty_test_str, short_test_str, 1)
    print_str(empty_test_str)
    
    newline
    
	strncpy(empty_test_str, long_test_str, 3)
	print_str(empty_test_str)
	
	newline
	
	strncpy(empty_test_str, long_test_str, 100)
	print_str(empty_test_str)
    

    # Завершение программы
    exit
