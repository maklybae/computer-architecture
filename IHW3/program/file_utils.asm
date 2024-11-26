.include "macro-syscalls.m"
.include "consts.m"

.globl read_close_file

.data
strbuf:	.space BUFF_SIZE

.text 
# function takes file_descriptor in a0, returns address of text start in a0, total len in a2
read_close_file:
	# save s* registers in stack
	addi sp, sp, -32
	sw s0, 28(sp)
	sw s1, 24(sp)
	sw s2, 20(sp)
	sw s3, 16(sp)
	sw s4, 12(sp)
	sw s5, 8(sp)
	sw s6, 4(sp)
	sw ra, 0(sp)
	
	mv s0, a0
	li s1, -1 # check correctness
	
	# allocate memory in heap (size of heap)
    allocate(BUFF_SIZE)	# result in a0
    mv 		s3, a0 # save heap address in s3 register
    mv 		s5, a0 # save temp heap address in s5 register
    li		s4, BUFF_SIZE # save const
    mv		s6, zero # init len

read_loop:
    read_addr_reg(s0, s5, BUFF_SIZE) # read BUFF_SIZE from s0 file with heap start s5
    # check correctness
    beq	a0, s1, er_read # err occured
    mv s2, a0 # save text len
    add s6, s6, s2	# add current len to total len

    bne	s2, s4, end_loop # if eof

	# else
    allocate(BUFF_SIZE)
    add	s5, s5, s2 # shift temp heap address
    b read_loop
    
end_loop:
    mv	t0 s3		# copy of text start address
    add t0 t0 s6	# last symbol address
    addi t0 t0 1	# address for zero
    sb	zero (t0)	# save zero
    
    close(s0)
    mv a0, s3 # text start address
    mv a1, s6 # total len
    
	# restore stack
    lw s0, 28(sp)
	lw s1, 24(sp)
	lw s2, 20(sp)
	lw s3, 16(sp)
	lw s4, 12(sp)
	lw s5, 8(sp)
	lw s6, 4(sp)
	lw ra, 0(sp)
	addi sp, sp, 32
    
	ret

# fatal error
er_read:
	close(s0)
	fatal
