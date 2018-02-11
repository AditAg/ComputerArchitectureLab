.data
	prompt: .asciiz "Enter the value of n: "
	prompt2: .asciiz "The factorial is: "
	prompt3: .asciiz "\n"
	prompt4: .asciiz "END.\n"


.text

	factorial:
		li $t1, 1
		li $t2, 1
		addi $t0, $t0, 1

		loop:
			beq $t2,$t0, end_loop
			mul $t1, $t1, $t2
			add $t2, 1
			j loop

		end_loop:
			jr $ra

	main:

		li $v0, 4
		la $a0, prompt
		syscall

		li $v0,5
		syscall

		move $t0,$v0

		jal factorial

		li $v0, 4
		la $a0, prompt2
		syscall

		li $v0, 1
		move $a0, $t1
		syscall

		li $v0, 4
		la $a0, prompt4
		syscall

		li $v0, 10
		syscall