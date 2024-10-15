.globl generate_arr_b

.text
generate_arr_b:
	# save sp and s* to stack
	addi sp, sp, -28
	sw ra, 24(sp)
	sw s1, 20(sp)
	sw s2, 16(sp)
	sw s3, 12(sp)
	sw s4, 8(sp)
	sw s5, 4(sp)
	sw s6, (sp)
	
	mv s1, a0 # arr_a_ptr
	mv s2, a1 # arr_b_ptr
	mv s3, a2 # n
	
	mv s4, s1 # arr_a_ptr copy
	li s5, 0 # arr_a_counter
generate_arr_b_even_loop:
	lw s6, (s4) # current element of arr_a
	sw s6, (s2)
	# increment
	addi s2, s2, 4
	addi s4, s4, 8
	addi s5, s5, 2
	blt s5, s3, generate_arr_b_even_loop

	addi s4, s1, 4 # arr_a_ptr copy shifted to element with index 1
	li s5, 1 # arr_a_counter
generate_arr_b_odd_loop:
	lw s6, (s4) # current element of arr_a
	sw s6, (s2)
	# increment
	addi s2, s2, 4
	addi s4, s4, 8
	addi s5, s5, 2
	blt s5, s3, generate_arr_b_odd_loop
	
	# restore stack
	lw ra, 24(sp)
	lw s1, 20(sp)
	lw s2, 16(sp)
	lw s3, 12(sp)
	lw s4, 8(sp)
	lw s5, 4(sp)
	lw s6, (sp)
    addi sp, sp, 28
    ret
