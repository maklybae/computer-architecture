#
# Main program uses macro library and external subprogram
#
.include "macro-common.mac"
.include "macro-is-class.mac"

    .data
pi:
    .double 3.14192
exp:
    .float 2.71828


    .text
main:
	fld     ft0, pi, t4    # double pi
    flw     ft1, exp, t4   # exp float
    isFloatClass(ft0, FLOAT)
    #print_int(t2)
    #newline
    isFloatClass(ft0, DOUBLE)
    #print_int(t2)
    #newline
    isFloatClass(ft1, 32)
    #print_int(t2)
    #newline
    isFloatClass(ft1, 64)
    #print_int(t2)
    #newline
    isFloatClass(ft0, 80)
    #print_int(t2)
    #newline
    exit
