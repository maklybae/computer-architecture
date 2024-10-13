# Рекурсивное вычисление факториала
# Вызывающая программа
        li      a7 5
        ecall			# Аргумент для вычислений
        jal     fact            # Параметр уже в a0 )
        li      a7 1		# Вывод результата
        ecall                   # Параметр уже в a0 ))
        li      a7 10
        ecall
# Подпрограмма вычисления факториала
fact:   addi    sp sp -8        ## Запасаем две ячейки в стеке
        sw      ra 4(sp)        ## Сохраняем ra
        sw      s1 (sp)         ## Сохраняем s1

        mv      s1 a0           # Запоминаем N в s1
        addi    a0 s1 -1        # Формируем n-1 в a0
        li      t0 1
        ble     a0 t0 done      # Если n<2, готово
        jal     fact            # посчитаем (n-1)!
        mul     s1 s1 a0        # s1 пережил вызов
	# Возврат из подпрограммы
done:   mv      a0 s1           # Возвращаемое значение
        lw      s1 (sp)         ## Восстанавливаем sp
        lw      ra 4(sp)        ## Восстанавливаем ra
        addi    sp sp 8         ## Восстанавливаем вершину стека
        ret
       
       