.text
newmem: li      a7 9            # Закажем память (объём уже в a0)
        ecall
        addi    sp sp -4
        sw      a0 (sp)         # Сохраним адрес
        li      a7 34           # Выведем адрес (a0 уже задан)
        ecall                   # как 16-ричное число
        li      a0 10           # Выведем перевод строки
        li      a7 11
        ecall
        lw      a0 (sp)         # Вспомним адрес
        addi    sp sp 4
        ret

.globl main
main:   li      a0 0x100       # Закажем 256 байтов
        jal     newmem
        li      a0 0x101       # закажем 257 байтов
        jal     newmem
        li      a0 0x100       # Закажем опять 256 байтов
        jal     newmem

