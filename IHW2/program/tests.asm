.include "macrolib.asm"

.data
	s_n: .asciz "x = "
	s_expected: .asciz "expected result: "
	s_result: .asciz "result: "
	
	input1: .double 0.0
	exp1: .double 0.0
	
	input2: .double 1.0
	exp2: .double 1.0
	
	input3: .double -1.0
	exp3: .double 1.0
	
	input4: .double 1000.0
	exp4: .double 10.0
	
	input5: .double -1000.0
	exp5: .double -10.0
	
	input6: .double 0.027
	exp6: .double 0.3
	
	input7: .double -0.027
	exp7: .double -0.3
	
	input8: .double 1.23456789
	exp8: .double 1.0728
	
	input9: .double -1.23456789
	exp9: .double -1.0728
	
	input10: .double 123124123.123
	exp10: .double 497.486
	
	input11: .double -123124123.123
	exp11: .double -497.486
	
.text
	macro_run_test(input1, exp1, s_n, s_expected, s_result)
	macro_run_test(input2, exp2, s_n, s_expected, s_result)
	macro_run_test(input3, exp3, s_n, s_expected, s_result)
	macro_run_test(input4, exp4, s_n, s_expected, s_result)
	macro_run_test(input5, exp5, s_n, s_expected, s_result)
	macro_run_test(input6, exp6, s_n, s_expected, s_result)
	macro_run_test(input7, exp7, s_n, s_expected, s_result)
	macro_run_test(input8, exp8, s_n, s_expected, s_result)
	macro_run_test(input9, exp9, s_n, s_expected, s_result)
	macro_run_test(input10, exp10, s_n, s_expected, s_result)
	macro_run_test(input11, exp11, s_n, s_expected, s_result)
	
	# breakpoint
	li a7, 10
	ecall
	

	