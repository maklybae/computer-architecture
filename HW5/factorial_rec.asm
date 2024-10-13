.data
    s_result:  .asciz "Maxarg for 32bit factorial is "
	
.text
main:
	# Print text
	la 	a0, s_result
	li 	a7, 4
	ecall
	
	# func call
	li a0, 1
	li a1, 1
	jal factorial_maxarg
	
	# Print result
    li a7, 1
    ecall
    # Exit
    li a7, 10
    ecall
    
factorial_maxarg:
	# int factorial_maxarg(cur, res):
	# 	inc_cur = cur + 1;
	# 	if (check_overflow(inc_cur, res)) return cur;
	# 	res *= inc_cur;
	# 	return factorial_maxarg(inc_cur, res);
	
	# a0/s0(cur)
	# a1/s1(res)
	# t0(inc_cur)
	
	addi t0, a0, 1
	
	# check_overflow call
	addi sp, sp, -16
	sw ra, 12(sp)
	sw a0, 8(sp)
	sw a1, 4(sp)
	sw t0, (sp)
	jal check_overflow
	lw ra, 12(sp)
	lw s0, 8(sp)
	lw s1, 4(sp)
	lw t0, (sp)
	addi sp, sp, 16
	
	# if overflow
	bnez a0, factorial_maxarg_overflow
	
	# else rec call
	addi sp, sp, -4
	sw ra, (sp)
	mv a0, t0
	mul a1, s1, t0
	jal factorial_maxarg
	lw ra, (sp)
	addi sp, sp, 4
	ret
	
factorial_maxarg_overflow:
	mv a0, s0
	ret
	
	
	
check_overflow:
	# check overflow for a0 * a1; if (overflow) return 0;
	mul t0, a0, a1
	div t1, t0, a0
	
	bne t1 a1 check_overflow_true
	li a0 0
	ret
check_overflow_true:
	li a0 1
	ret

	