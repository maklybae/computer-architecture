# Рекурсивное вычисление факториала без использования
# регистров s*, сохраняемых на стеке
        li      a7 5
        ecall
        jal     fact            # Параметр уже в a0 )
        li      a7 1
        ecall                   # Параметр уже в a0 ))
        li      a7 10
        ecall

fact:   addi    sp sp -4
        sw      ra (sp)         # Сохраняем ra
        mv      t1 a0           # Запоминаем N в t1
        addi    a0 t1 -1        # Формируем n-1 в a0
        li      t0 1
        ble     a0 t0 done      # Если n<2, готово
        addi    sp sp -4        ## Сохраняем t1 на стеке
        sw      t1 (sp)         ##
        jal     fact            # Посчитаем (n-1)!
        lw      t1 (sp)         ## Вспоминаем t1
        addi    sp sp 4         ##
        mul     t1 t1 a0        # Домножаем на (n-1)!
done:   mv      a0 t1           # Возвращаемое значение
        lw      ra (sp)         # Восстанавливаем ra
        addi    sp sp 4         # Восстанавливаем вершину стека
        ret

