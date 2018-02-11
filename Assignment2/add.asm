.data
	prompt : .asciiz "Enter the 1st number: "
	prompt2 : .asciiz "Enter the 2nd number: "
	prompt3 : .asciiz "The result is : "
	prompt4 : .asciiz "Exiting.\n"
	prompt5 : .asciiz "\n"

.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	
	li $v0, 4
	la $a0, prompt2
	syscall
	
	li $v0,5
	syscall
	move $t1, $v0

	add $t2, $t0, $t1
	li $v0, 4
	la $a0, prompt3
	syscall
	li $v0,1
	move $a0,$t2
	syscall

	li $v0,4
	la $a0,prompt5
	syscall
	li $v0,4
	la $a0,prompt4
	syscall
	
	li $v0,10
	syscall
