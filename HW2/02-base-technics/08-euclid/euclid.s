#
# Calculates the greatest common divisor of two values using the Euclidean algorithm.
#
# function gcd(a, b)
#    while a ≠ b
#        if a > b
#            a := a − b
#        else
#            b := b − a
#    return a

.data    
    arg01:  .asciz "Input 1st number: "
    arg02:  .asciz "Input 2nd number: "
    result: .asciz "Result = "
    ln:     .asciz "\n"

.text
main:
    la 	a0, arg01	# Подсказка для ввода первого числа
    li 	a7, 4       	# Системный вызов №4. Ввод строки в стиле Си
    ecall

    li  a7, 5	    	# Системный вызов №5. Ввод целого
    ecall
    mv  t1, a0

    la 	a0, arg02	# Подсказка для ввода второго числа
    li 	a7, 4       	# Системный вызов №4. Ввод строки в стиле Си
    ecall

    li  a7, 5
    ecall
    mv  t2, a0

loop:
    beq t1, t2, finish

    slt t0, t1, t2
    bne t0, zero, if_less

    sub t1, t1, t2
    b   loop

if_less:
    sub t2, t2, t1
    b   loop

finish:
    la a0, result       # Подсказка для выводимого результата
    li a7, 4            # Системный вызов №4
    ecall

    li  a7, 1 		# Системный вызов №1 — вывести десятичное число
    mv  a0, t1
    ecall

    la 	a0, ln          # Перевод строки
    li  a7, 4           # Системный вызов №4
    ecall

    li      a7 10       # Системный вызов №10 — останов программы
    ecall
