.include "macro-common.mac"
.data
Exact:  .asciz  " - это точное решение!\n"
Inex:   .asciz  " - результат неточный (с округлением).\n"

.text
		print_str ("Считаем по формуле: (a + b) / c\n")
		print_str ("a = ")
        li      a7 6
        ecall
        fmv.s   fs0 fa0         # A
		print_str ("b = ")
        li      a7 6
        ecall
        fmv.s   fs1 fa0         # B
		print_str ("c = ")
        li      a7 6
        ecall
        fmv.s   fs2 fa0         # C

        fadd.s  ft0 fs0 fs1
        frflags t0              # Флаги FPU
        andi    t0 t0 1         # Потеря точности?
        fdiv.s  fa0 ft0 fs2
        frflags t1              # Флаги FPU
        andi    t1 t1 1         # Потеря точности?
        or      s1 t0 t1        # …хотя бы раз
		print_str ("Result = ")
        li      a7 2
        ecall
        la      a0 Inex
        bnez    s1 out
        la      a0 Exact

out:    li      a7 4
        ecall
        li      a7 10
        ecall
