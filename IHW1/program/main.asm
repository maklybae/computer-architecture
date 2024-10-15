.data
	arr_a: .space 40
	arr_b: .space 40

.include "macrolib.asm"

.text
main:
	# space in stack for local varibales
	addi sp, sp, -4
	
	# save n to stack and copy to s1
	macro_get_saveaddr_n(sp)
	lw s1, (sp)
	
	macro_get_array_elements(arr_a, s1)
	macro_generate_arr_b(arr_a, arr_b, s1)
	macro_output_array(arr_b, s1)
	macro_exit
