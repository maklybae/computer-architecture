#
# Calculates the greatest common divisor of two values using the Euclidean algorithm.
#
# int euclid(a, b) {
#    while (a != b)
#        if (a > b) a = a − b;
#        else b := b − a;
#    return a;
# }

.include "macrolib.s"

main:
    print_str ("Euclid algorithm\n")
    print_str ("Input 1st number: ")
    read_int (t1)
    print_str ("Input 1st number: ")
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
    print_str ("Result = ")
    print_int (t1)
    print_char('\n')
