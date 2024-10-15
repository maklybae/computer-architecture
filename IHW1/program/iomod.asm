.include "macrolib.asm"

.globl get_check_n
.globl get_array_elements
.globl output_array

.eqv EMaxN 10

.data
	s_enter_n: .asciz  "enter n from 1 to 10: "
	s_enter_int: .asciz  "enter integer: "
	.align 2
	

.text
get_check_n:
	# save sp and s* to stack
	addi sp, sp, -8
	sw ra, 4(sp)
	sw s1, (sp)
	
    # load max_n to s1
    li s1, EMaxN
get_check_n_loop:
	# hint for user and input
	macro_print_str(s_enter_n)
	macro_read_int_a0
    # check n: allowed values: [1, 10]
    blez a0, get_check_n_loop
    bgt	a0, s1, get_check_n_loop
    
    # user's n passed all checks
    # restore stack
    lw ra, 4(sp)
    lw s0, (sp)
    addi sp, sp, 8
    # return n value (in a0)
    ret


get_array_elements:
	# save sp and s* to stack
	addi sp, sp, -12
	sw ra, 8(sp)
	sw s1, 4(sp)
	sw s2, (sp)
	
	mv s1, a0
	mv s2, a1	
get_array_elements_loop:
	# hint for user and input
	macro_print_str(s_enter_int)
	macro_read_int_a0
    sw a0, (s1)
    # check counter
    addi s1, s1, 4
	addi s2, s2, -1
	bgtz s2, get_array_elements_loop

    # restore stack
	lw ra, 8(sp)
	lw s1, 4(sp)
	lw s2, (sp)
    addi sp, sp, 12
    ret
	
output_array:
	# save sp and s* to stack
	addi sp, sp, -12
	sw ra, 8(sp)
	sw s1, 4(sp)
	sw s2, (sp)

	mv s1, a0
	mv s2, a1

output_array_loop:
	# output current element
	lw a0, (s1)
	macro_print_int_a0
	
	# separator
	macro_print_char(' ')
	
	# increment
	addi s1, s1, 4
	addi s2, s2, -1
	bgtz s2, output_array_loop

	# restore stack
	lw ra, 8(sp)
	lw s1, 4(sp)
	lw s2, (sp)
    addi sp, sp, 12
    ret
