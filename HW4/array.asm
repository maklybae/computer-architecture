.data
sep:    .asciz  "--------\n"    # Строка-разделитель (с \n и нулём в конце)
enter_n: .asciz  "n = ? "         # Подсказка для ввода числа
error:  .asciz  "incorrect n!\n"  # Сообщение о некорректном вводе
error_overflow_sum: .asciz "overflow! last sum is " # Сообщение о переполнении
error_overflow_count: .asciz "; count = "
sum_message: .asciz "sum = "
odd_message: .asciz "count_odd = "
even_message: .asciz "; count_even = "
.align  2                       # Выравнивание на границу слова
n:	.word	0		# Число введенных элементов массива
array:  .space  40              # 64 байта
.text
in:
        la 	a0, enter_n      # Подсказка для ввода числа элементов массива
        li 	a7, 4           # Системный вызов №4
        ecall
        li a7, 5            # Системный вызов №5 — ввести десятичное число
        ecall
        mv t3, a0           # Сохраняем результат в t3 (это n)
        ble t3, zero, fail    # На ошибку, если меньше 0
        li t4, 10           # Размер массива
        bgt t3, t4, fail      # На ошибку, если больше 16
        la t4, n		# Адрес n в t4
        sw	t3, (t4)		# Загрузка n в память на хранение
        
        la t0, array        # Указатель элемента массива
        
fill:
		li a7, 5            # Системный вызов №5 — ввести десятичное число
        ecall
        sw a0, (t0)
        addi t0, t0, 4         # Увеличим адрес на размер слова в байтах
        addi t3, t3, -1        # Уменьшим количество оставшихся элементов на 1
        bnez t3, fill         # Если осталось больш 0
        la a0, sep          # Выведем строку-разделитель
        li a7, 4
        ecall
		
        lw	t3, n		# Число элементов массива
        la t0, array  # Начало массива
        
sum_check:
		# в t5 хранится сумма
		# в t1 загружаем очередное число
		lw t1, (t0)
		
		# в t6 положим t1 xor t5
		xor t6, t1, t5
if_xor_ltz:
		bgez t6, if_a_pos
		j end_if
if_a_pos:
		blez t1, else
		li a0, 0x7FFFFFFF
		sub t6, a0, t1
		bgt t5, t6, overflow
		j end_if
else:
		li a0, 0x80000000
		sub t6, a0, t1
		blt t5, t6 overflow
		
end_if:
		add t5, t5, t1	
		addi t0, t0, 4
        addi t3, t3, -1        # Уменьшим количество оставшихся элементов на 1
        bnez t3, sum_check          # Если осталось больше 0
        
       	lw t3, n		# Число элементов массива
        la t0, array  # Начало массива
        j out_sum

overflow:
		la 	a0, error_overflow_sum       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           # Системный вызов №4
        ecall
        li a7, 1
        mv a0, t5
        ecall
        
        la 	a0, error_overflow_count       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           # Системный вызов №4
        ecall
        li a7, 1
        lw	t2 n
       	sub a0, t2, t3
        ecall
        li a0, '\n'         # Выведем перевод строки
        li a7, 11
        ecall
        
        j count_odd_even

out_sum:
		la 	a0, sum_message       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           # Системный вызов №4
        ecall
		li a7, 1
		mv a0, t5
        ecall
        li a0, '\n'         # Выведем перевод строки
        li a7, 11
        ecall
        
count_odd_even:
		lw t3, n		# Число элементов массива
        la t0, array  # Начало массива
        li t5, 0
        li t2, 2

count_odd_even_loop:
		# в t1 загружаем очередное число
		lw t1, (t0)
		remu t6, t1, t2
		add t5, t5, t6
		addi t0, t0, 4
        addi t3, t3, -1        # Уменьшим количество оставшихся элементов на 1
        bnez t3, count_odd_even_loop

out_odd_even:
		la	a0, odd_message       # Сообщение об ошибке ввода числа элементов массива
        li	a7, 4           # Системный вызов №4
        ecall
        li a7, 1
        mv a0, t5
        ecall
        
        la 	a0, even_message       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           # Системный вызов №4
        ecall
        lw	t3, n
        sub a0, t3, t5
        li a7, 1
        ecall
        
        li a0, '\n'         # Выведем перевод строки
        li a7, 11
        ecall
        j breakpoint       

fail:
        la 	a0, error       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           # Системный вызов №4
        ecall
        
breakpoint:
		li a7, 10           # Останов
        ecall
