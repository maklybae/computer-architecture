	.data
array:  .space  64
arrend:
	.text
	la      t0 array
	la      t1 arrend
	li      t2 1
loop:   sw      t2 (t0)
	addi    t2 t2 1
	addi    t0 t0 4
	bltu    t0 t1 loop
        li      a7 10           # Останов
        ecall