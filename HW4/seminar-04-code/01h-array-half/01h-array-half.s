.data
sep:    .asciz  "--------\n"    # Строка-разделитель (с \n и нулём в конце)
.align  2                       # Выравнивание на границу слова
array:  .space  64              # 64 байта
arrend:                         # Граница массива
.text
        la      t0 array        # Счётчик
        la      s1 arrend
        li      t2 1            # Число, которое мы будем записывать в массив
fill:   sh      t2 (t0)         # Запись числа по адресу в t0
        addi    t2 t2 1         # Изменим число
        addi    t0 t0 2         # Увеличим адрес на размер слова в байтах
        bltu    t0 s1 fill      # Если не вышли за границу массива
        la      a0 sep          # Выведем строку-разделитель
        li      a7 4
        ecall
        la      t0 array
out:    li      a7 1
        lh      a0 (t0)         # Выведем очередной элемент массива
        ecall
        li      a7 11           # Выведем перевод строки
        li      a0 10
        ecall
        addi    t0 t0 2
        blt     t0 s1 out
        li      a7 10           # Останов
        ecall
