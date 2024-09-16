main:
mv t0, zero 	# псевдокоманда
li t1, 1	# псевдокоманда

li a7, 5	# псевдокоманда
ecall 		# type I
mv t3, a0 	# псевдокоманда
fib:
beqz t3, finish # псевдокоманда
add t2, t1, t0  # type R
mv t0, t1	# псевдокоманда
mv t1, t2	# псевдокоманда
addi t3, t3, -1 # type I
j fib		# псевдокоманда
finish:
li a7, 1	# псевдокоманда
mv a0, t0	# псевдокоманда
ecall		# type I
