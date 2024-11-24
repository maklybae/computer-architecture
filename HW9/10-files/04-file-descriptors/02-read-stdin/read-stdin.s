# Чтение текста из стандартного потока ввода (тест возможности)
.eqv    TEXT_SIZE 2048	# Размер буфера для текста

    .data
er_read_mes:    .asciz "Incorrect read operation\n"
.align 2
strbuf:	.space TEXT_SIZE			# Буфер для читаемого текста
        .text
    ###############################################################
    # Чтение информации из stdin = 0
    li   a7, 63       # Системный вызов для чтения из файла
    mv   a0, zero       # Дескриптор stdin
    #mv   a0, s0       # Дескриптор файл
    la   a1, strbuf   # Адрес буфера для читаемого текста
    #li   a2, TEXT_SIZE # Максимальный размер читаемой порции
    li   a2 5
    ecall             # Чтение
    # Проверка на корректное чтение
    beq		a0 s1 er_read	# Ошибка чтения
    mv   	s2 a0       	# Сохранение длины текста
    ###############################################################
    # Вывод длины прочитанного сообщения
    li a7 1
    ecall
    li a0 '\n'
    li a7 11   
    ecall
    ###############################################################
    # Установка нуля в конце прочитанной строки
    la	t0 strbuf	 # Адрес начала буфера
    add t0 t0 s2	 # Адрес последнего прочитанного символа
    addi t0 t0 1	 # Место для нуля
    sb	zero (t0)	 # Запись нуля в конец текста
    ###############################################################
    # Вывод текста на консоль
    la 	a0 strbuf
    li 	a7 4
    ecall
    # Завершение  программы
    li a7 10
    ecall
er_read:
    # Сообщение об ошибочном чтении
    la		a0 er_read_mes
    li		a7 4
    ecall
    # И завершение программы
    li		a7 10
    ecall
