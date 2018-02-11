
.data
	prompt :	.asciiz "Enter the 1st number: "
	prompt2 : .asciiz "\nEnter the 2nd number: "
	prompt3 : .asciiz "\nThe gcd of the numbers is: "
	prompt4 : .asciiz "\n"
	prompt5 : .asciiz "Exiting.\n"

.text
#gcd:
#	lab:
#		#computes values in registers t0, t1 and result is put into t2
#		beqz $t1, return
#		move $a0,$t0
#		move $t0, $t1
#		div $a0, $t0   #Here the result gets stored in LO and HI, a mod b is stored in HI and a/b is stored in Lo 
#		mfhi $t1       #move from HI 
#		j lab
#
#return:
#	move $t2, $t0
#	jr $ra
main:

	#a0-a3 are for syscall arguments, v0 is for syscall number
	#Prompt the user to enter the 1st number
	li $v0,4                        # For printing a string, the code is 4
	la $a0, prompt                  #la - load address
	syscall

	#Get the input of 1st number
	li $v0, 5                       #5 is the syscall for reading integers
	syscall
	#Number gets stored in v0

	#Store the number in t0
	move $t0, $v0                        #Here we can also use an addi (add immediate) instruction
	#addi $sp,-4
	#sw $v0, ($sp) 


	#Prompt the user to enter the 2nd number
	li $v0, 4
	la $a0, prompt2
	syscall

	#Get the input of 2nd number
	li $v0, 5                           
	syscall
	#Number gets stored in v1

	#Store the number in t1
	move $t1,$v0

	#FUNCTION CALL
	#jal gcd


start:
	beq $t0, $t1, end

	sub $t2, $t0, $t1
	bltz $t2, start2

	sub $t0, $t0, $t1
	j start

start2:
	sub $t1, $t1, $t0
	j start

end:
	move $t2, $t0


	#Display the result
	li $v0, 4                   
	la $a0, prompt3
	syscall

	#Print the result
	li $v0, 1                   #The code for printing an integer is 1
	move $a0, $t2               #result is stored in t2
	syscall

	li $v0, 4
	la $a0, prompt4
	syscall

	#Print exit string
	li $v0, 4
	la $a0, prompt5
	syscall

	#exit syscall
	li $v0, 10                #10 is the syscall used for exit
	syscall