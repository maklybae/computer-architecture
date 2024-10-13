.data
ping:   .asciz  "Ping\n"
.text
        jal     subr    # Использование команды jal

        la      s1 subr # Использование команды jalr
        jalr    s1

        li      a7 10
        ecall

# Подпрограмма, выводящая заданную строку ping
subr:   la      a0 ping
        li      a7 4
        ecall
        ret


