# Проверка вариантов работы со стандартными потоками ввода-вывода
# Через системные вызовы read и  write
.eqv    stdin  0			# стандартный поток ввода
.eqv    stdout 1			# стандартный поток вывода
.eqv    stderr 2			# стандартный поток ошибок
.eqv    BUF_SIZE 50			# Размер буфера для текста

.data
#  Буфер для тестирования ввода с заполнителем
strbuf:	.asciz  "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
.align 2

.text
	###############################################################
    # Чтение информации из stdin, размещающейся в буфере
    # При этом перевод строки присутствует
    li   a7, 63       # Системный вызов для чтения из файла
    mv   a0, zero       # Дескриптор stdin
    #mv   a0, s0       # Дескриптор файл
    la   a1, strbuf   # Адрес буфера для читаемого текста
    li   a2  BUF_SIZE
    ecall             # Чтение
    mv   	s2 a0       	# Сохранение длины текста
    ###############################################################
    # Вывод числа прочитанных элементов с использованием stdout
	li a0 1			# stdout
	la a1 strbuf    # адрес буфера
	li a2 BUF_SIZE	# число выводимых элементов
    li a7 64
    ecall
    li a0 '\n'
    li a7 11   
    ecall
    ###############################################################
    # Вывод числа прочитанных элементов с использованием stderr
	li a0 2			# stderr
	la a1 strbuf    # адрес буфера
	li a2 BUF_SIZE	# число выводимых элементов
    li a7 64
    ecall
    li a0 '\n'
    li a7 11   
    ecall
	###############################################################
    # Чтение информации из stdin, которая не помещается в отведенное место
    # моделируется укорченным значением прочитанных символов, 
    # при вводе более длинной строки
    # При этом перевод строки отсутствует
    li   a7, 63       # Системный вызов для чтения из файла
    mv   a0, zero       # Дескриптор stdin
    la   a1, strbuf   # Адрес буфера для читаемого текста
    li   a2  5		  # Максимум 5 символов
    ecall             # Чтение
    mv   	s2 a0       	# Сохранение длины текста
    ###############################################################
    # Вывод числа прочитанных элементов с использованием stdout
	li a0 1			# stdout
	la a1 strbuf    # адрес буфера
	li a2 BUF_SIZE	# число выводимых элементов
    li a7 64
    ecall
    li a0 '\n'
    li a7 11   
    ecall
    ###############################################################
    # Вывод числа прочитанных элементов с использованием stderr
	li a0 2			# stderr
	la a1 strbuf    # адрес буфера
	li a2 BUF_SIZE	# число выводимых элементов
    li a7 64
    ecall
    li a0 '\n'
    li a7 11   
    ecall
    ###############################################################
    # Завершение  программы
    li a7 10
    ecall
