#
# Calculates the greatest common divisor of two values using the Euclidean algorithm.
#
# int euclid(a, b) {
#    while (a != b)
#        if (a > b) a = a − b;
#        else b := b − a;
#    return a;
# }
.global euclid

	.text
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
