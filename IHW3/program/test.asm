.include "macro-syscalls.m"
.include "consts.m" 

.data
test1_input: .asciz "../test_data/test-all.txt"
test1_output: .asciz "../test_data/output/test-all.o"

test2_input: .asciz "../test_data/test-digits"
test2_output: .asciz "../test_data/output/test-digits.o"

test3_input: .asciz "../test_data/test-multi_line.extension"
test3_output: .asciz "../test_data/output/test-multi_line.o"

test4_input: .asciz "../test_data/test-one_line"
test4_output: .asciz "../test_data/output/test-one_line.o"

test5_input: .asciz "../test_data/test-strange"
test5_output: .asciz "../test_data/output/test-strange.o"

.text
	# test1
	open_fatal_reg(test1_input, READ_ONLY, s1)
	read_close_file(s1, s2, s3)
	
	capitalize_vowels(s2)
	
	open_fatal_reg(test1_output, WRITE_ONLY, s4)
	write_addr(s4, s2, s3)
	close(s4)
	
	# test2
	open_fatal_reg(test2_input, READ_ONLY, s1)
	read_close_file(s1, s2, s3)
	
	capitalize_vowels(s2)
	
	open_fatal_reg(test2_output, WRITE_ONLY, s4)
	write_addr(s4, s2, s3)
	close(s4)
	
	# test3
	open_fatal_reg(test3_input, READ_ONLY, s1)
	read_close_file(s1, s2, s3)
	
	capitalize_vowels(s2)
	
	open_fatal_reg(test3_output, WRITE_ONLY, s4)
	write_addr(s4, s2, s3)
	close(s4)
	
	# test4
	open_fatal_reg(test4_input, READ_ONLY, s1)
	read_close_file(s1, s2, s3)
	
	capitalize_vowels(s2)
	
	open_fatal_reg(test4_output, WRITE_ONLY, s4)
	write_addr(s4, s2, s3)
	close(s4)
	
	# test5
	open_fatal_reg(test5_input, READ_ONLY, s1)
	read_close_file(s1, s2, s3)
	
	capitalize_vowels(s2)
	
	open_fatal_reg(test5_output, WRITE_ONLY, s4)
	write_addr(s4, s2, s3)
	close(s4)
	
	print_str("Testing finished.\n")
	print_str("Output files saved to ../test_data/output/")
	
	exit
	
	
