.data
	prompt: .asciiz "Please enter the value of the number that you want to calculate the factorial of : "
	prompt2: .asciiz "The value of the factorial is : "
	theNumber: .word 0
	theAnswer: .word 0


.text
	.globl main
	main:

		#Read the Number from the User
		li $v0, 4
		la $a0, prompt
		syscall

		li $v0, 5
		syscall

		sw $v0, theNumber

		#Call the factorial function
		lw $a0, theNumber
		jal factorial
		sw $v0, theAnswer

		#Output the result
		li $v0, 4
		la $a0, prompt2
		syscall

		li $v0, 1
		lw $a0, theAnswer
		syscall

		#End
		li $v0, 10
		syscall	 

#--------------------------------------------------------
	.globl factorial
	factorial:
		#The first step is to store the local variables and return address to the stack
		subu $sp, $sp, 8  #There's only 1 local variable, i.e. n and the return address, so 8 bytes
		sw $ra, 0($sp)
		sw $s0, 4($sp)

		#Base Case
		li $v0, 1
		beqz $a0, factorial_end

		#Recursive Step, find factorial of number-1
		move $s0, $a0
		sub $a0, $a0, 1
		jal factorial

		mul $v0, $s0, $v0

	factorial_end:
		lw $ra, ($sp)
		lw $s0, 4($sp)
		addu $sp, $sp, 8
		
		jr $ra




