.include "macro-syscalls.m"
.include "consts.m"

.globl input_file_path
.globl output_file_path


.data
input_file_path: .space PATH_SIZE
output_file_path: .space PATH_SIZE

.text
main:
	# get input file path and open it
	jal get_input_file_path
	open_fatal_reg(input_file_path, READ_ONLY, s1)
	
	read_close_file(s1, s2, s3) # s1 - file_descriptor, s2 - text start addr, s3 - len
	
	capitalize_vowels(s2)
	
	# print readed text from input file
	jal get_yn
	beqz a0, file_output
	print_str("Output:\n")
	print_str_addr(s2)

file_output:
	# get output file path and open it  
    jal get_output_file_path
    open_fatal_reg(output_file_path, WRITE_ONLY, s4)
	
	write_addr(s4, s2, s3)
    
	close(s4)
	exit
