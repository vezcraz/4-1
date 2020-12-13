.data
	prompt: .asciiz "Fibonacci Calculation\nEnter number:\n"
	result: .asciiz "F_"

.text
	main:
	li $v0,4
	la $a0,prompt   
	syscall
	
	#user input
	li $v0,5    
	syscall
	
	#calling function
	move  $a0, $v0
	bgt $a0,46,overflow
	jal fibo
	
	#printing 
	move $a0, $v0
	li $v0,1
	syscall
	
	#exit condition
	li $v0,10
	syscall
	
	#fib calc
	fibo:
	#base case
	beq $a0,0,zero
	beq $a0, 1,one
	
	#recursive call for fibo(n-1)
	sub $sp,$sp,4
	sw $ra, 0($sp)
	sub $a0,$a0,1
	jal fibo
	
	#loading back the address to caller function	
	lw $ra,0($sp)
	
	#store return value to stack
	sw $v0,0($sp)
	
	
	#recursive call for fibo(n-2)
	sub $sp,$sp,4   
	sw $ra,0($sp)
	sub $a0,$a0,1
	jal fibo
	
	#restore value of n in a0
	add $a0,$a0,2
	
	#load back address for caller
	lw $ra,0($sp)
	add $sp,$sp,4
	#load back return value for fibo(n-1) from stack
	lw $s1,0($sp)
	add $sp,$sp,4
	
	#v0 = fibo(n-2), s1 = fibo(n-1). adding them would give the answer
	add $v0,$v0,$s1 
	jr $ra 
	
	zero:
	li $v0,0
	jr $ra
	
	one:
	li $v0,1
	jr $ra
	
	overflow:
	li $v0,0
	move $a0, $v0
	li $v0,1
	syscall
	
	