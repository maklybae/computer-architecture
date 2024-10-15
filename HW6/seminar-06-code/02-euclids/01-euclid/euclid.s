#
# Calculates the greatest common divisor of two
# values using the Euclidean algorithm.
#
# int euclid(a, b) {
#    while (a != b)
#        if (a > b) a = a − b;
#        else b := b − a;
#    return a;
# }

# Ввод целого числа в заданный регистр
.macro read_int(%x)
   li a7, 5
   ecall
   mv %x, a0
.end_macro

# Печать содержимого регистра как целого
.macro print_int (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro

main:
    read_int (t1)
    read_int (t2)

loop:
    beq t1, t2, finish

    slt t0, t1, t2
    bne t0, zero, if_less

    sub t1, t1, t2
    j   loop

if_less:
    sub t2, t2, t1
    j   loop

finish:
    print_int (t1)
