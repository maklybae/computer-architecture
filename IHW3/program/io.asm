.include "macro-syscalls.m"
.include "consts.m" 

.globl get_input_file_path 
.globl get_output_file_path
.globl get_yn

.text
# takes nothing, return string in a0
get_input_file_path:
	print_str ("Input path to file for reading: ")
	str_get(input_file_path, PATH_SIZE)
	ret

# takes nothing, return string in a0
get_output_file_path:
	print_str ("Input path to file for writing: ")
	str_get(output_file_path, PATH_SIZE)
	ret

# takes noting, return 0 for NO, 1 for YES
get_yn:
	print_str("Print output to console? [Y/N]")
	read_char(t0)
	li t1, 'Y'
	beq t0, t1, y # if yes
	
	li t1, 'N'
	beq t0, t1, n # if no
	
	#else
	print_str("Unsupported character, consider NO\n")
	b n

y:
	li a0, 1
	ret
	
n:
	li a0, 0
	ret