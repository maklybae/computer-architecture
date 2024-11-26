.globl capitalize_vowels

.text
# capitalize_vowels function takes address of string begin, returns nothing (UB in a0)
capitalize_vowels:
loop:
    lb t1, (a0) # load symbol from source
    beqz t1, end
    
  	li t0, 'a'
  	beq t1, t0, change # check if t1 is 'a'
	li t0, 'e'
  	beq t1, t0, change # check if t1 is 'e'
  	li t0, 'i'
  	beq t1, t0, change # check if t1 is 'i'
  	li t0, 'o'
  	beq t1, t0, change # check if t1 is 'o'
  	li t0, 'u'
  	beq t1, t0, change # check if t1 is 'u'
  	
  	addi a0, a0, 1 # incr destination pointer
  	b loop # continue
  	
end:
	ret

change:
	# offset in ascii table to make upper
	addi t1, t1, -32
	sb t1, (a0) # store changed byte
	b loop # continue

    
