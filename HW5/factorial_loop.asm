.data
    s_result:  .asciz "Maxarg for 32bit factorial is "
	
.text
main:
	# Print text
	la 	a0, s_result
	li 	a7, 4
	ecall
	
	# func call
	jal factorial_maxarg
	
	# Print result
    li a7, 1
    ecall
    # Exit
    li a7, 10
    ecall
    
factorial_maxarg:
	# cur = 2;
	# res = 1;
	# while check_overflow(res, cur) {
	# 	res *= cur++;
	# }
	# return cur - 1;
	
	# t0(cur)
	li t0, 2
	# t1(res)
	li t1, 1

factorial_maxarg_while:
	# check_overflow call
	addi sp, sp, -12
	sw ra, 8(sp)
	sw t0, 4(sp)
	sw t1, (sp)
	mv a0, t0
	mv a1, t1
	jal check_overflow
	lw ra, 8(sp)
	lw t0, 4(sp)
	lw t1, (sp)
	addi sp, sp, 12
	
	bnez a0, factorial_maxarg_endwhile
	mul t1, t1, t0
	addi t0, t0, 1
	j factorial_maxarg_while
factorial_maxarg_endwhile:
	addi a0, t0, -1
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
