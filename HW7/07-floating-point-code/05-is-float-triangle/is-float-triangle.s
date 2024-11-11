.data
yes:    .asciz  "It is a triangle\n"
no:     .asciz  "It is not a triangle\n"
.text
        jal     input
        fmv.d   fs2 fa0
        jal     input
        fmv.d   fs1 fa0
        jal     input
        fmv.d   fa1 fs1
        fmv.d   fa2 fs2
        jal     check
        bnez    a0 true
        la      a0 no
        b       output
true:   la      a0 yes
output: li      a7 4
        ecall
        li      a7 10
        ecall

.data
prompt: .ascii  "Enter triangle side: "
.text
input:  la      a0 prompt
        li      a7 4
        ecall
        li      a7 7
        ecall
        ret

check:  fadd.d  ft0 fa1 fa2
        flt.d   t0 fa0 ft0
        fadd.d  ft1 fa2 fa0
        flt.d   t1 fa1 ft1
        fadd.d  ft2 fa1 fa0
        flt.d   t2 fa2 ft2
        and     a0 t0 t1
        and     a0 a0 t2
        ret
