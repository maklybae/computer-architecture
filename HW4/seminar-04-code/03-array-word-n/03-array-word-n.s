.data
sep:    .asciz  "--------\n"    # Строка-разделитель (с \n и нулём в конце)
prompt: .asciz  "n = ? "         # Подсказка для ввода числа
error:  .asciz  "incorrect n!\n"  # Сообщение о некорректном вводе
.align  2                       # Выравнивание на границу слова
n:	.word	0		# Число введенных элементов массива
array:  .space  64              # 64 байта
.text
in:
        la 	a0, prompt      # Подсказка для ввода числа элементов массива
        li 	a7, 4           # Системный вызов №4
        ecall
        li      a7 5            # Системный вызов №5 — ввести десятичное число
        ecall
        mv      t3 a0           # Сохраняем результат в t3 (это n)
        ble     t3 zero fail    # На ошибку, если меньше 0
        li      t4 0x00000010           # Размер массива
        bgt     t3 t4 fail      # На ошибку, если больше 16
        la	t4 n		# Адрес n в t4
        sw	t3 (t4)		# Загрузка n в память на хранение
        
        la      t0 array        # Указатель элемента массива
        li      t2 1            # Число, которое мы будем записывать в массив
fill:   sw      t2 (t0)         # Запись числа по адресу в t0
        addi    t2 t2 1         # Изменим число
        addi    t0 t0 4         # Увеличим адрес на размер слова в байтах
        addi    t3 t3 -1        # Уменьшим количество оставшихся элементов на 1
        bnez    t3 fill         # Если осталось больш 0
        # bltu    t0 s1 fill      # Если не вышли за границу массива
        la      a0 sep          # Выведем строку-разделитель
        li      a7 4
        ecall

        lw	t3 n		# Число элементов массива
        la      t0 array
out:    li      a7 1
        lw      a0 (t0)         # Выведем очередной элемент массива
        ecall
        li      a0 '\n'         # Выведем перевод строки
        li      a7 11
        ecall
        addi    t0 t0 4
        addi    t3 t3 -1        # Уменьшим количество оставшихся элементов на 1
        bnez    t3 out          # Если осталось больше 0
        # blt     t0 s1 out
        li      a7 10           # Останов
        ecall
fail:
        la 	a0, error       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           # Системный вызов №4
        ecall
        li      a7 10           # Останов
        ecall
