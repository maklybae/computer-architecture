# Пример использования стека в RARS

li t1 123        # t1 = 123
addi sp sp -4    # сместить указатель стека вниз на 1 слово
sw t1 (sp)       # положить содержимое t1 на стек
addi t2 t1 100   # t2 = t1 + 100
addi sp sp -4    # сместить указатель стека вниз еще на 1 слово
sw t2 (sp)       # положить содержимое t2 на стек
lw t3 (sp)       # загрузить содержимое с вершины стека
lw t4 4(sp)      # загрузить содержимое первого загруженного значения
addi sp sp 4     # "убрать" со стека элемент (pop)
lw t0 (sp)       # загрузить содержимое с вершины стека
addi sp sp -4    # сместить указатель стека вниз на 1 слово
sw zero (sp)     # положить на стек значение = 0

