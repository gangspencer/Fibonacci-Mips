#Spencer Gang, 2636582S, Programming Assignment 2, CIS480

        .data
intro:   .asciiz "========Fibonacci Calculator=======\nCalculates first n fibonacci numbers\nCIS 480, Spencer Gang, 2636582\n"
name_prompt: .asciiz"Enter your name: "
name_space: .space 64
greeting: .asciiz "\nWelcome "
get_n_prompt: .asciiz "\nInput a number n between 1 and 47 (inclusive): "
error_n_prompt: .asciiz "\nError, number not between 1 and 47 inclusive...restarting\n"
fibonacci_space: .asciiz "    "
exit_prompt: .asciiz "\nGoodbye"
new_line: .asciiz " \n"


        .text
        .globl main
main:   
	#INTRO - DESCRIPTION AND NAME (STEP 1)
	li $v0, 4       		#syscall 4 (print_str)
        la $a0, intro	    		#argument: string
        syscall         		#print the string
        
        li $v0, 4			#syscall 4 (print_str)
        la $a0, name_prompt		#argument: string
        syscall
        
        li $v0, 8			#syscall 8 (read_str)
        la $a0, name_space		#load name space
        li $a1, 64			#allocate 64 bytes
        move $t8, $a0			#save name to $t8
        syscall
        
        li $v0, 4			#syscall 4 (print_str)
        la $a0, greeting		#argument_string
        syscall
        
        li $v0, 4			#syscall 4 (print_str)
        la $a0, name_space		#load name_space address
        move $a0, $t8			#primary address = name
        syscall
        
        #GET N 
        li $v0, 4			#syscall 4 (print_str)
        la $a0, get_n_prompt		#argument: string
        syscall
        
        li $v0, 5			#syscall 5 (read_int)
	syscall
	move $t0, $v0			#copy input into $t0
	li $t1, 1			#load minimum
	li $t2, 47			#load maximum
	
check_n:
	blt $t0, $t1, error_n		#if $t0 < 1 => error_n
	bgt $t0, $t2, error_n		#if $t0 > 47 => error_n
	j get_fib			#continue
	
	
	#ERROR N OUT OF RANGE (STEP 2)
error_n:
	li $v0, 4			#syscall 4 (print_str)
	la $a0, error_n_prompt		#argument: string
	syscall
			
	li $v0, 4			#syscall 4 (print_str)
	la $a0, get_n_prompt		#argument: string
	syscall
	
	li $v0, 5			#syscall 5 (read_int)
	syscall
	j check_n			#jump to check_n
	
	#FIBONACCI 
get_fib:
	li $t3, 0			#load 0 into $t3 (current value)
	li $t4, 1			#load 1 into $t4 (next value)
	li $t5, 0			#iterator
	
	li $v0, 1 			#syscall 4 (print_str)
	move $a0, $t3			#argument
	syscall				#print 0 because we're guarunteed
	li $v0, 4			#syscall 4 (print_str)
	la $a0, fibonacci_space		#print space
	syscall
	#t0 = n

fib_loop:
	blt $t5, $t0, fib
	li $v0, 10
	syscall
	
fib:
	li $v0, 1			#syscall 4 (print_int)
	move $a0, $t4			#argument int
	syscall
	
	li $v0, 4			#syscall 4 (print_str)
	la $a0, fibonacci_space		#print space
	syscall
	
	add $t6, $t3, $t4 		#temp = current + next
	move $t3, $t4			#current = next
	move $t4, $t6			#next = temp
	addi $t5, $t5, 1		#i = i + 1
	j fib_loop

	
	#i = 0 ($t5)
	#while i < n ($t5 < $t0)
		#print next value ($t4)
		#temp value = current value + next value ($t8 = $t3 + $t4)
		#current = next value ($t3 = $t4)
		#next value = temp value ($t4 = $t8)
		#n++ ($t0)

print_zero:
	li $v0, 1 			#syscall 4 (print_str)
	move $a0, $t4			#argument
	syscall
	
	li $v0, 4			#syscall 4 (print_str)
	la $a0, fibonacci_space		#print space
	syscall
	addi $t5, $t5, 1
	
	j fib_loop			#jump to fib loop
	


	
	
	
	

							

