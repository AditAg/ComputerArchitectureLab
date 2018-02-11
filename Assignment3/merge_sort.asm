.data
	prompt: .asciiz "Enter the value "
	newline: .asciiz "\n"
	output: .asciiz "The input array is:"
	prompt2: .asciiz "Enter the size of the array "
	prompt3: .asciiz " : "
	prompt4: .asciiz " of array "
	end: .asciiz "END."
	values: .asciiz "Values of t7 and t8 are : "
	output_array: .asciiz "The output array is : "
	
	.align 2
	A: .space 1000     #integers of 4 bytes each    
	B: .space 1000	   # temporary array


.text
	.globl main

	merge:
		
		li $t5, 0
		li $t6, 0
		
		merge_loop:
			beq $t5,$t0,merge_loop1
			beq $t6,$t1,merge_loop2
			lw $t7, 0($t2)
			lw $t8, 0($t3)

			slt $t9, $t7, $t8
			beqz $t9, second_is_lesser
			sw $t7,($t4)
			add $t2, 4
			add $t5, 1
			add $t4, 4
			j merge_loop

		
		second_is_lesser:
			sw $t8,($t4)
			add $t3, 4
			add $t6, 1
			add $t4, 4
			j merge_loop

		merge_loop1:
			loop_single:
				beq $t6,$t1,end_merge_loop
				lw $t8, ($t3)
				sw $t8, ($t4)
				add $t3, 4
				add $t6, 1
				add $t4, 4
				j loop_single

		merge_loop2:
			loop_single2:
				beq $t5,$t0,end_merge_loop
				lw $t7, 0($t2)
				sw $t7, ($t4)
				add $t2, 4
				add $t5, 1
				add $t4, 4
				j loop_single2

		end_merge_loop:
			jr $ra
			
	main:

		#get array size 1
		li $v0, 4
		la $a0, prompt2
		syscall 
	
		li $v0, 5
		syscall
	
		move $t0, $v0
	
		# get array 1

		la $t2, A
		li $t3, 1
		add $t0, 1
		
		loop:
			beq $t3,$t0,endloop
			li $v0, 4
			la $a0, prompt
			syscall

			li $v0, 1
			move $a0, $t3
			syscall
				
			li $v0,4
			la $a0, prompt4
			syscall
				
			li $v0, 1
			li $a0, 1
			syscall
					
			li $v0, 4
			la $a0, prompt3
			syscall
				
			li $v0, 5
			syscall
			
			sw $v0, 0($t2)
			
			add $t2, 4
			add $t3, 1
			
			j loop

		endloop:
			
			addi $t0,-1
			la $a0, A
			move $a1, $t0  
			move $s0, $t0

			jal merge_sort
	
			li $v0, 4
			la $a0, output_array
			syscall
			
			la $t2, A
			li $t3, 0			

			print:
				beq $t3,$s0,program_end
				
				li $v0, 1
				lw $a0, ($t2)
				syscall
				
				li $v0,4
				la $a0, newline
				syscall
				
				add $t3, 1
				add $t2, 4
				j print
			
			program_end:
				li $v0, 4
				la $a0, newline
				syscall

				li $v0, 4
				la $a0, end
				syscall
			
				li $v0, 10
				syscall

	merge_sort:
		subu $sp, $sp, 16
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		#Base Case
		li $t5, 1
		beq $t5, $a1, return

		move $s1, $a0
		move $s0, $a1
		sra $a1, $a1, 1

		jal merge_sort

		move $a1, $s0
		move $s2, $s0
		sra $a2, $a1, 1
		sub $a1, $a1, $a2
		sll $t1, $a2, 2
		add $a0, $s1, $t1
		
		jal merge_sort


		move $t0, $s0
		sra $t0, $t0, 1
		sub $t1, $s0, $t0
		move $t2, $s1
		sll $t8, $t0, 2
		add $t3, $s1, $t8
		la $t4, B


		jal merge

		la $t4, B
		li $t7, 0

		move $a2, $s1

		loop6:
			beq $t7, $s0, return
			lw $t6, 0($t4)
			sw $t6, 0($a2)
			
			
			move $a0, $t6
			li $v0, 1
			syscall

			addi $t7, 1
			addi $a2, 4
			addi $t4, 4
			j loop6

		return:
			li $v0, 4
			la $a0, newline
			syscall

			move $a0, $a3
			
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			lw $s1, 8($sp)
			lw $s2, 12($sp)
			addu $sp, $sp, 16
			jr $ra