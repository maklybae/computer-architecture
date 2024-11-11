.data
numb:   .float  7.5

.text
        flw     ft0 numb t0
        fcvt.w.s a0 ft0         # По умолчанию RNE (ближайшее, чётное) = 8
        jal     outn
        fcvt.w.s a0 ft0 rtz     # Ближайшее к 0 = 7
        jal     outn
        li      t0 2            # RDN — ближайшее к минус бесконечности = 7
        fsrm    t0
        fcvt.w.s a0 ft0         # теперь по умолчанию RDN = 7
        jal     outn
        fcvt.w.s a0 ft0 dyn     # Не менять установленное по умолчанию = 7
        jal     outn
        fcvt.w.s a0 ft0 rne     # RNE (ближайшее, чётное) = 8
        jal     outn

        li      a7 10
        ecall

outn:   li      a7 1
        ecall
        li      a0 '\n'
        li      a7 11
        ecall
        ret
