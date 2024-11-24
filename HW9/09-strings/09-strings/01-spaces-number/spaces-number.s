.eqv    SIZE 100                # размер буфера
.data
str:    .space SIZE             # буфер
.text
        la      a0 str          # считаем строку в буфер
        li      a1 SIZE
        li      a7 8
        ecall
        mv      t0 zero         # счётчик пробелов
        li      t2 0x20         # пробел
loop:   lb      t1 (a0)         # очередной символ
        beqz    t1 fin          # нулевой — конец строки
        bne     t1 t2 nosp      # не пробел — обойдём счётчик
        addi    t0 t0 1         # пробел — увеличим счётчик
nosp:   addi    a0 a0 1         # следующий символ
        b       loop
fin:    mv      a0 t0           # выведем счётчик
        li      a7 1
        ecall
        li      a7 10
        ecall
