# common macros

# read double to fa0 register
.macro macro_read_double_fa0
   li a7, 7
   ecall
.end_macro

# read double to any register
.macro macro_read_double(%x)
   macro_read_double_fa0
   mv %x, fa0
.end_macro

# print double from fa0 register
.macro macro_print_double_fa0
	li a7, 3
	ecall
.end_macro

# print double from any register
.macro macro_print_double(%x)
	fmv.d fa0, %x
	macro_print_double_fa0
.end_macro

.macro macro_print_double_addr(%x)
	fld fa0, %x, t0
	macro_print_double_fa0
.end_macro

# load address by label to a0 and ecall 4 
.macro macro_print_str (%x)
   li a7, 4
   la a0, %x
   ecall
.end_macro

# print char %x
.macro macro_print_char(%x)
   li a7, 11
   li a0, %x
   ecall
.end_macro

# print newline
.macro macro_newline
   macro_print_char('\n')
.end_macro

# exit(0)
.macro macro_exit
    li a7, 10
    ecall
.end_macro

# macro to run testcase
.macro macro_run_test(%x, %exp, %s_n, %s_expected, %s_result)
	# prompt
	la a0, %s_n
	li a7, 4
	ecall
	
	# output initial x
	macro_print_double_addr(%x)
	
	macro_newline
	
	# prompt
	macro_print_str(%s_expected)
	
	# output expected
	macro_print_double_addr(%exp)
	
	macro_newline
	
	# prompt
	macro_print_str(%s_result)
	
	# run function
	fld fa0, %x, t0
	jal cube_root
	
	macro_print_double_fa0
	
	macro_newline	
	macro_newline
.end_macro

# program specific macros

.macro macro_cube_root(%from, %to)
	# run function to find cube root
	# pass x in fa0, return cube root of x in fa0
	fmv.d fa0, %from
	jal cube_root
	fmv.d %to, fa0
.end_macro

.macro macro_read_x(%x)
	# read double and save it to fs1
	# pass nothing, return x in a0
	jal read_x
	fmv.d fs1, fa0
.end_macro

.macro macro_print_root_x(%x)
	# output answer
	# pass cube root of x in fa0, return nothing
	jal print_root_x
	fmv.d fa0, %x
.end_macro