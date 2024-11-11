        .data
    x:      .double 12.34
        .text
    li              t2 2
    fcvt.d.w        ft2 t2                  # ft2 = 2.0
    li              t1 1
    fcvt.d.w        ft1 t1                  # ft1 = 1.0
    fld             ft0 x t0                # ft0 = x
    fnmsub.d        ft3 ft2 ft0 ft1         # ft3 = -(2 * x) + 1
    fmadd.d         fa0 ft0 ft0 ft3         # fa0 = x * x + ft3
    li              a7 3                    # Вывод числа двойной точности
    ecall

    li              a7 10
    ecall