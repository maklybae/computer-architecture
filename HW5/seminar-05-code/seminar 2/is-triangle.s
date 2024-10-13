.data
yes:    .asciz  "It is a triangle\n"
no:     .asciz  "It is not a triangle\n"
# Основная программа
.text
        jal     input
        mv      s1 a0
        jal     input
        mv      s2 a0
        jal     input
        mv      s3 a0
        jal     check           # проверка неравенства треугольника
        la      a0 no           # запись адреса no в регистр a0 (занимает две инструкции!!!)
        li      a7 4            # вывод строки в a0 (сюда возврат в случае успеха: ra+8)
        ecall
        li      a7 10
        ecall

.data
prompt: .ascii  "Enter triangle side: "
.text
# Подпрограмма ввода одной стороны треугольника
input:  la      a0 prompt
        li      a7 4
        ecall
        li      a7 5
        ecall
        ret

# Подпрограмма проверки отрезков на треугольник
check:  add     t3 s1 s2
        add     t1 s2 s3
        add     t2 s1 s3
        ble     t1 s1 notri
        ble     t2 s2 notri
        ble     t3 s3 notri
        la      a0 yes
        jalr    zero ra 8  # "Суровый" (зависимый от контекста) возврат
notri:  ret

