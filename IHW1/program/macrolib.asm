# print int from a0 register
.macro macro_print_int_a0
    li a7, 1
    ecall
.end_macro

# read int to a0 register
.macro macro_read_int_a0
   li a7, 5
   ecall
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

.macro macro_get_saveaddr_n(%x)
	# call get_check_n: take no arguments, return n in a0
	jal get_check_n
	# save result to address in %x
	sw a0, (%x)
.end_macro

.macro macro_get_array_elements(%x, %y)
	# call get_array_elements: arr_ptr(a0 from %x), n(a1 from %y); return void; (undefined value in a0)
	la a0, %x
	mv a1, %y
	jal get_array_elements
.end_macro

.macro macro_generate_arr_b(%x, %y, %z)
	# call generate_arr_b: arr_a_ptr(a0 from %x), arr_b_ptr(a1 from %y), n(a2 from %z); return void; (undefined value in a0)
	la a0, %x
	la a1, %y
	mv a2, %z
	jal generate_arr_b
.end_macro

.macro macro_output_array(%x, %y)
# call ouput_array: arr_ptr(a0 from %x), n(a1 from %y); return void; (undefined value in a0)
	la a0, %x
	mv a1, %y
	jal output_array
	macro_newline
.end_macro

.macro macro_compare(%x, %y, %z)
	# call compare: arr_b(a0 from %x), expected(a1 from %y), n(a2 from %z)
	la a0, %x
	la a1, %y
	mv a2, %z
	jal compare
.end_macro
