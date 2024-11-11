.include "macrolib.asm"

.data
	tolerance: .double 0.0005

.globl cube_root

.text
# cube_root function
cube_root:
	# y = x  # Начальное приближение
    # while True:
    #     y_next = (2 * y + x / (y ** 2)) / 3
    #     # Проверка на достижение заданной точности
    #     if abs(y_next - y) / y_next < tolerance:
    #         return y_next
    #     y = y_next
    
    # variables mapping
	# fs1 <-> x
	# fs2 <-> y
	# fs3 <-> y_next
	# fs4 <-> tolerance
	# s1 <-> sign of x

	# add to stack (also ret address)
	addi sp, sp, -40
	fsd fs1, 32(sp)
	fsd fs2, 24(sp)
	fsd fs3, 16(sp)
	fsd fs4, 8(sp)
	sw s1, 4(sp)
	sw ra, 0(sp)
	
	# check for zero (ans is the same as input - zero)
	li t0, 0
	fcvt.d.w ft0, t0
	feq.d t0, fa0, ft0
	bgtz t0, cube_root_ret
	
	# store sign of x and call abs(x)
	# 0.0 is already in ft0
	flt.d s1, fa0, ft0
	# pass x in fa0, return abs(x) in fa0
	jal abs
	
	# load tolerance
	fld fs4, tolerance, t0
	
	fmv.d fs1, fa0 # copy of x
	fmv.d fs2, fa0 # y
	

cube_root_loop:
	# second term
	fmv.d ft2, fs1
	fdiv.d ft2, ft2, fs2
	fdiv.d ft2, ft2, fs2
	
	# numerator
	li t0, 2
	fcvt.d.w ft0, t0
	fmadd.d fs3, ft0, fs2, ft2
	
	# y_next will be in fs3
	li t0, 3
	fcvt.d.w ft0, t0
	fdiv.d fs3, fs3, ft0
	
	# calling abs function to get abs of (y_next - y) and calculate abs(...)/y_next
	fsub.d fa0, fs3, fs2
	# pass x in fa0, return abs(x) in fa0
	jal abs
	fdiv.d ft0, fa0, fs3
	
	# compare with tolerance
	fgt.d t0, ft0, fs4
	beqz t0, cube_root_prepare_ret
	fmv.d fs2, fs3
	j cube_root_loop

cube_root_prepare_ret:
	# change sign if initial x < 0
	beqz s1 cube_root_ret
	fneg.d fs3, fs3
cube_root_ret:
	fmv.d fa0, fs3
	
	fld fs1, 32(sp)
	fld fs2, 24(sp)
	fld fs3, 16(sp)
	fld fs4, 8(sp)
	lw s1, 4(sp)
	lw ra, 0(sp)
	addi sp, sp, -40
	ret

# abs function
abs:
	li t0, 0
	fcvt.d.w ft0, t0

	# if x < 0
	flt.d t0, fa0, ft0
	beqz t0, abs_ret
	fneg.d fa0, fa0
abs_ret:
	ret