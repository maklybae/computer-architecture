.include "macrolib.asm"

.data
	s_error: .asciz "compare error. expected: "

	# array1
	n1: .word 1
	arr1: .word 0
	expected1: .word 0
	
	#array2
	n2: .word 2
	arr2: .word 0
		.word 1
	expected2: .word 0
		.word 1
		
	#array3
	n3: .word 3
	arr3: .word 0
		.word 1
		.word 2
	expected3: .word 0
		.word 2
		.word 1

	#array4
	n4: .word 4
	arr4: .word 0
		.word 1
		.word 2
		.word 3
	expected4: .word 0
		.word 2
		.word 1
		.word 3
		
	#array5
	n5: .word 5
	arr5: .word 0
		.word 1
		.word 2
		.word 3
		.word 4
	expected5: .word 0
		.word 2
		.word 4
		.word 1
		.word 3
	
	#array6
	n6: .word 6
	arr6: .word 0
		.word 1
		.word 2
		.word 3
		.word 4
		.word 5
	expected6: .word 0
		.word 2
		.word 4
		.word 1
		.word 3
		.word 5

	#array7
	n7: .word 7
	arr7: .word 0
		.word 1
		.word 2
		.word 3
		.word 4
		.word 5
		.word 6
	expected7: .word 0
		.word 2
		.word 4
		.word 6
		.word 1
		.word 3
		.word 5	
	
	#array8
	n8: .word 8
	arr8: .word 0
		.word 1
		.word 2
		.word 3
		.word 4
		.word 5
		.word 6
		.word 7
	expected8: .word 0
		.word 2
		.word 4
		.word 6
		.word 1
		.word 3
		.word 5	
		.word 7

	#array9
	n9: .word 9
	arr9: .word 0
		.word 1
		.word 2
		.word 3
		.word 4
		.word 5
		.word 6
		.word 7
		.word 8
	expected9: .word 0
		.word 2
		.word 4
		.word 6
		.word 8
		.word 1
		.word 3
		.word 5	
		.word 7
		
	#array10
	n10: .word 10
	arr10: .word 0
		.word 1
		.word 2
		.word 3
		.word 4
		.word 5
		.word 6
		.word 7
		.word 8
		.word 9
	expected10: .word 0
		.word 2
		.word 4
		.word 6
		.word 8
		.word 1
		.word 3
		.word 5	
		.word 7
		.word 9
	
	arr_result: .space 40
	
		
.text
tests:
	#array1
	lw s1, n1
	macro_output_array(arr1, s1)
	macro_generate_arr_b(arr1, arr_result, s1)
	macro_output_array(arr_result, s1)
	macro_compare(arr_result, expected1, s1)
	macro_newline
	macro_newline
	
	#array2
	lw s1, n2
	macro_output_array(arr2, s1)
	macro_generate_arr_b(arr2, arr_result, s1)
	macro_output_array(arr_result, s1)
	macro_compare(arr_result, expected2, s1)
	macro_newline
	macro_newline
	
	#array3
	lw s1, n3
	macro_output_array(arr3, s1)
	macro_generate_arr_b(arr3, arr_result, s1)
	macro_output_array(arr_result, s1)
	macro_compare(arr_result, expected3, s1)
	macro_newline
	macro_newline
	
	#array4
	lw s1, n4
	macro_output_array(arr4, s1)
	macro_generate_arr_b(arr4, arr_result, s1)
	macro_output_array(arr_result, s1)
	macro_compare(arr_result, expected4, s1)
	macro_newline
	macro_newline
	
	#array5
	lw s1, n5
	macro_output_array(arr5, s1)
	macro_generate_arr_b(arr5, arr_result, s1)
	macro_output_array(arr_result, s1)
	macro_compare(arr_result, expected5, s1)
	macro_newline
	macro_newline
	
	#array6
	lw s1, n6
	macro_output_array(arr6, s1)
	macro_generate_arr_b(arr6, arr_result, s1)
	macro_output_array(arr_result, s1)
	macro_compare(arr_result, expected6, s1)
	macro_newline
	macro_newline
	
	#array7
	lw s1, n7
	macro_output_array(arr7, s1)
	macro_generate_arr_b(arr7, arr_result, s1)
	macro_output_array(arr_result, s1)
	macro_compare(arr_result, expected7, s1)
	macro_newline
	macro_newline
	
	#array8
	lw s1, n8
	macro_output_array(arr8, s1)
	macro_generate_arr_b(arr8, arr_result, s1)
	macro_output_array(arr_result, s1)
	macro_compare(arr_result, expected8, s1)
	macro_newline
	macro_newline
	
	#array9
	lw s1, n9
	macro_output_array(arr9, s1)
	macro_generate_arr_b(arr9, arr_result, s1)
	macro_output_array(arr_result, s1)
	macro_compare(arr_result, expected9, s1)
	macro_newline
	macro_newline
	
	#array10
	lw s1, n10
	macro_output_array(arr10, s1)
	macro_generate_arr_b(arr10, arr_result, s1)
	macro_output_array(arr_result, s1)
	macro_compare(arr_result, expected10, s1)
	macro_newline
	macro_newline
	
	macro_exit
	
	
compare:
	# save sp and s* to stack
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s1, 24(sp)
	sw s2, 20(sp)
	sw s3, 16(sp)
	sw s4, 12(sp)
	sw s5, 8(sp)
	sw s6, 4(sp)
	sw s7, (sp)
	
	mv s1, a0 # arr_b
	mv s2, a1 # expected
	mv s3, a2 # n
	mv s4, a1 # expected copy
	mv s7, a2 # n copy
	
compare_loop:
	lw s5, (s1) # current elem in arr_b
	lw s6, (s4) # current expected
	#increment
	addi s1, s1, 4
	addi s4, s4, 4
	addi s3, s3, -1
	bne s5, s6, compare_error
	bgtz s3, compare_loop
	j compare_final
	
compare_error:
	# error message for user
	la a0, s_error
	li 	a7, 4
	ecall
	# output array
	mv a0, s2
	mv a1, s7
	jal output_array

compare_final:
	# restore stack
	lw ra, 28(sp)
	lw s1, 24(sp)
	lw s2, 20(sp)
	lw s3, 16(sp)
	lw s4, 12(sp)
	lw s5, 8(sp)
	lw s6, 4(sp)
	lw s7, (sp)
    addi sp, sp, 32
    ret
