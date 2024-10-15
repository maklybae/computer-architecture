#
# Main program uses macro library and external subprogram
#
.include "macrolib.s"

.global main
#.extern euclid, 32

    .text
main:
    print_str ("Euclid algorithm\n")
    print_str ("Input 1st number: ")
    read_int_a0
    print_str ("Input 2nd number: ")
    read_int (a1)
    jal	euclid
    print_str ("Greatest common divisor = ")
    print_int (a0)
    newline
    exit
