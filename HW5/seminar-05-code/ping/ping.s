.data
ping:   .asciz  "Ping\n"
.text
        jal     subr
        la      s1 subr
        jalr    s1
        li      a7 10
        ecall
subr:   la      a0 ping
        li      a7 4
        ecall
        ret

