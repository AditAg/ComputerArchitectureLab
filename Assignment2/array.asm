.data
	prompt : .asciiz "Enter the value : "
	start : .asciiz "The Input Array is : "
	end : .asciiz "END."
	prompt2 : .asciiz "\n"
	prompt3 : .asciiz "The maximum value in the array is : "

	.align 2
	A: .space 32         #8 integers of 4 bytes each

	.globl main

.text

main:
	la $t0, A
	li $t1, 1
	li $t2, 0x80000001

	loop:
		beq $t1,9,exit
		li $v0, 4
		la $a0, prompt
		syscall
		li $v0,5
		syscall
		sw $v0, 0($t0)

		slt $t3, $t2, $v0
		movn $t2, $v0, $t3

		add $t1,1
		add $t0,4
		j loop
	exit:
		li $v0, 4
		la $a0, start
		syscall

		li $v0, 4
		la $a0, prompt2
		syscall

		la $t0, A
		li $t1, 1

	printloop:
		li $v0, 1
		lw $a0, ($t0)
		syscall
		li $v0,4
		la $a0, prompt2
		syscall
		add $t0, 4
		add $t1, 1
		beq $t1,9, endloop
		j printloop
	
	endloop:
		li $v0, 4
		la $a0, prompt3
		syscall
		li $v0, 1
		move $a0, $t2
		syscall

		li $v0, 4
		la $a0, prompt2
		syscall

		li $v0, 4
		la $a0, end
		syscall

		li $v0, 10
		syscall
