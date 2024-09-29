.data    
    s_arg01:  .asciz "Input 1st number: "
    s_arg02:  .asciz "Input 2nd number: "
    s_result_div: .asciz "a / b = "
    s_result_mod: .asciz "a % b = "
    s_error_div_by_0: .asciz "Error: Division by zero"
    s_ln:     .asciz "\n"

.text
main:
    la 	a0, s_arg01	# Подсказка для ввода первого числа
    li 	a7, 4       	# Системный вызов №4. Ввод строки в стиле Си
    ecall

    li  a7, 5	    	# Системный вызов №5. Ввод целого
    ecall
    mv  t1, a0

    la 	a0, s_arg02	# Подсказка для ввода второго числа
    li 	a7, 4       	# Системный вызов №4. Ввод строки в стиле Си
    ecall

    li  a7, 5
    ecall
    mv  t2, a0
    
    beqz t2, error_div_by_0 # if t2 == 0
    
    mv t4, t1 # future result of t1 % t2
   	bgez t1, pos_num # if t1 >= 0
   	j neg_num
    
error_div_by_0: # Ошибка: деление на ноль
	la 	a0, s_error_div_by_0
    li 	a7, 4
    ecall
    j breakpoint
    
pos_num: # Положительный числитель
	bgtz t2, pos_num_pos_den
	j pos_num_neg_den
	
pos_num_pos_den: # Положительный числитель и положительный знаменатель
	loop_pos_num_pos_den:
		blt t4, t2, finish
		addi t3, t3, 1
		sub t4, t4, t2
		j loop_pos_num_pos_den

pos_num_neg_den: # Положительный числитель и отрицательный знаменатель
	neg t2, t2
	loop_pos_num_neg_den:
		blt t4, t2, finish
		addi t3, t3, -1
		sub t4, t4, t2
		j loop_pos_num_neg_den

neg_num: # Отрицательный числитель
	bgtz t2, neg_num_pos_den
	j neg_num_neg_den

neg_num_pos_den: # Отрицательный числитель и положительный знаменатель
	neg t2, t2
	loop_neg_num_pos_den:
		bgt t4, t2, finish
		addi t3, t3, -1
		sub t4, t4, t2
		j loop_neg_num_pos_den

neg_num_neg_den: # Отрицательный числитель и отрицательный знаменатель
    loop_neg_num_neg_den:
		bgt t4, t2, finish
		addi t3, t3, 1
		sub t4, t4, t2
		j loop_neg_num_neg_den
    
finish: # Вывод результата
    la a0, s_result_div       # Подсказка для выводимого результата
    li a7, 4            # Системный вызов №4
    ecall

    li  a7, 1 		# Системный вызов №1 — вывести десятичное число
    mv  a0, t3
    ecall

    la 	a0, s_ln          # Перевод строки
    li  a7, 4           # Системный вызов №4
    ecall
    
    la a0, s_result_mod       # Подсказка для выводимого результата
    li a7, 4            # Системный вызов №4
    ecall

    li  a7, 1 		# Системный вызов №1 — вывести десятичное число
    mv  a0, t4
    ecall

    la 	a0, s_ln          # Перевод строки
    li  a7, 4           # Системный вызов №4
    ecall
    
    j breakpoint

breakpoint: # Останов
    li      a7 10       # Системный вызов №10 — останов программы
    ecall
