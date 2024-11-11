.include "macrolib.asm"

.text
main:
	macro_read_x(fs1)
	macro_cube_root(fs1, fs2)
	macro_print_root_x(fs2)
	
	macro_exit
