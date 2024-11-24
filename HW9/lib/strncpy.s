# Моделирование функции strncpy(destination, source, n)
.text
.globl strncpy
strncpy:
	mv t0, a2 # copy of n
	li t3, 0 # zero
	mv t4, a0 # copy of destination pointer
loop:
    lb t1, (a1) # load symbol from source
    beqz t1, padding # if symbol in source == 0 -> padding
    sb t1, (a0) # else save symbol to destination
    addi t0, t0, -1 # decr counter
    beqz t0, end # if counter == 0 -> end
    addi a0, a0, 1 # incr destination pointer
    addi a1, a1, 1 # incr source pointer
    b loop
padding:
	sb t3, (a0) # store 0 to destination
	addi t0, t0, -1 # decr counter
	beqz t0, end # if counter == 0 -> end
	b padding
end:
    mv a0, t4 # to change
    ret
