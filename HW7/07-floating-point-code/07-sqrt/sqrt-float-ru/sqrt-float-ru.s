        li      a7 5
        ecall                   # Ввод целого
        fcvt.s.w ft1 a0         # Преобразование в вещественное
        fmv.s.x ft0 zero        # 0 не надо преобразовывать!
        flt.s   t0 ft1 ft0      # t0 = ft1 < 0 ?
        fmv.s   fa0 ft0         # результат пока 0...
        bnez    t0 negat        # ... и останется 0, если число отрицательное
        fsqrt.s fa0 ft1         # вычислим корень
negat:  li      a7 2            # выведем результат
        ecall
        li      a7 10
        ecall
