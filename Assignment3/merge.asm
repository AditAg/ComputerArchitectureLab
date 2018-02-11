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
	B: .space 1000     
	C: .space 2000	   # space for output array

.text

	merge:
		#li $v0,1
		#lw $a0, 0($t2)
		#syscall

		#li $v0,4
		#la $a0,prompt3
		#syscall

		#li $v0,1
		#move $a0,$t0
		#syscall 
		
		#li $v0,4
		#la $a0,prompt3
		#syscall

		#li $v0,1
		#move $a0,$t1
		#syscall 

		#li $v0,4
		#la $a0,prompt3
		#syscall

		#li $v0,1
		#lw $a0, ($t3)
		#syscall 

		li $t5, 0
		li $t6, 0
		
		merge_loop:
			beq $t5,$t0,merge_loop1
			beq $t6,$t1,merge_loop2
			lw $t7, 0($t2)
			lw $t8, 0($t3)

			li $v0, 4
			la $a0, values
			syscall

			li $v0, 1
			move $a0, $t7
			syscall

			li $v0, 4
			la $a0, prompt3
			syscall

			li $v0,1
			move $a0, $t8
			syscall

			li $v0,4
			la $a0,newline
			syscall

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

		merge_loop2:
			loop_single2:
				beq $t5,$t0,end_merge_loop
				lw $t7, 0($t2)
				sw $t7, ($t4)
				add $t2, 4
				add $t5, 1
				add $t4, 4

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
	
		# get array size 2
		li $v0,4
		la $a0,prompt2
		syscall
		
		li $v0,1
		li $a0,2
		syscall
		
		li $v0,4
		la $a0,prompt3
		syscall
	
		li $v0,5
		syscall
		
		move $t1,$v0

		
		# get array 1

		la $t2, A
		li $t3, 0
		
		loop:
			beq $t3,$t0,endloop
			li $v0, 4
			la $a0, prompt
			syscall
			
			li $v0, 5 
			syscall
			
			sw $v0, 0($t2)
			
			add $t2, 4
			add $t3, 1
			
			j loop

		endloop:
			# get array 2
			la $t2, B
			li $t3, 1
			addi $t1,1
			
			loop2:
				beq $t3,$t1,endloop2
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
				li $a0, 2
				syscall
					
				li $v0, 4
				la $a0, prompt3
				syscall
				
				li $v0, 5
				syscall
			
				sw $v0, 0($t2)
			
				addi $t2, 4
				addi $t3, 1
				j loop2
		endloop2:
			
			addi $t1,-1
			la $t2, A
			la $t3, B
			la $t4, C

			jal merge
	
			li $v0, 4
			la $a0, output_array
			syscall
			
			la $t2, C
			add $t0, $t0, $t1
			li $t3, 0			

			print:
				beq $t3,$t0,program_end
				
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
			 
			
		
		
		
		
