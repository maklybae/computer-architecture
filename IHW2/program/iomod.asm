.include "macrolib.asm"

.data
	s_input_prompt: .asciz  "enter double: "
	s_output_prompt: .asciz "cube root: "
	.align 2

.globl read_x
.globl print_root_x

.text
read_x:
	# prompt
	macro_print_str(s_input_prompt)
	
	# input double
	macro_read_double_fa0
	ret
	
print_root_x:
	# prompt
	macro_print_str(s_output_prompt)
	
	# ouput double
	macro_print_double_fa0
	ret