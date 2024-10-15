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

# Is it OK?
    .text
main:
    print_str ("Euclid algorithm\n")
    print_str ("Input 1st number: ")
    read_int (a0)
    print_str ("Input 2nd number: ")
    read_int (a1)
    jal euclid
    print_str ("Greatest common divisor = ")
    print_int (a0)
    newline
    exit

euclid:
loop:
    beq a0, a1, finish      # if(a0==a1) goto finish;
    slt t0, a0, a1          # if(a0<a1)  t0 = 1; else t0 = 0;
    bne t0, zero, if_less   # if(t0==0)  goto if_less
    sub a0, a0, a1
    j   loop
if_less:
    sub a1, a1, a0
    j   loop
finish:
    ret
