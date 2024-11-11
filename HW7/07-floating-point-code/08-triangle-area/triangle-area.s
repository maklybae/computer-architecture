.data
yes:    .asciz  "It is a triangle\n"
no:     .asciz  "It is not a triangle\n"
area:   .asciz  "Area = \n"
.text
        # Последовательный ввод трех сторон
        jal     input
        fmv.s   fs2 fa0
        jal     input
        fmv.s   fs1 fa0
        jal     input
        fmv.s   fa1 fs1
        fmv.s   fa2 fs2

        jal     check      # Вызов проверки на треугольник

        # Это не треугольник
        bnez    a0 true
        la      a0 no
        li      a7 4
        ecall
        b       exit

        # Это треугольник.
true:   la      a0 yes
        li      a7 4
        ecall
        jal     geron   # Вычисление площади
        li		a7 2	# Вывод площади
        ecall
exit:
        li      a7 10
        ecall

# Ввод стороны треугольника
        .data
prompt: .ascii  "Enter triangle side: "
        .text
input:  la      a0 prompt
        li      a7 4
        ecall
        li      a7 6
        ecall
        ret

# Проверка, что это стороны треугольника
check:  fadd.s  ft0 fa1 fa2
        flt.s   t0 fa0 ft0
        fadd.s  ft1 fa2 fa0
        flt.s   t1 fa1 ft1
        fadd.s  ft2 fa1 fa0
        flt.s   t2 fa2 ft2
        and     a0 t0 t1
        and     a0 a0 t2
        ret

# Вычисление площади по формуле Герона
# Стороны остались в регистрах - параметрах
        .data
double_two: .float 2.0
        .text
geron:
		# Вычисления полупериметра
        fadd.s 	ft0 fa0 fa1
        fadd.s 	ft0 ft0 fa2
        flw		ft2 double_two t0
        fdiv.s 	ft0 ft0 ft2
        # Вычисление разностей
        fsub.s	ft3 ft0 fa0
        fsub.s	ft4 ft0 fa1
        fsub.s	ft5 ft0 fa2
        # Их перемножение
        fmul.s	ft1 ft3 ft4
        fmul.s	ft1 ft1 ft5
        fmul.s	ft1 ft1 ft0
        # Получение площади
        fsqrt.s	fa0 ft1
        ret
