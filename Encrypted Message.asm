.data
	ask: .asciiz "Please enter a message:\n"
	answer1: .asciiz "\nYour encrypted message:\n"
	answer2: .asciiz "\nYour decrypted message:\n"
	input: .byte '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'
	encrypt: .byte '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'
	decrypt: .byte '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'
	
.text
	# prompt to enter a message of 9 characters
	li $v0, 4
	la $a0, ask
	syscall
	
	# read input from console
	li $v0, 8
	li $a1, 10
	la $a0, input
	syscall
	
	# encrypt the message
	li $s0, 10
	la $s1, input
	la $s2, encrypt
	li $t0, 15
	
encrypting:
	beq $s0, $zero, continue
	lb $t1, 0($s1)
	xor $t2, $t1, $t0
	sb $t2, 0($s2)
	sub $s0, $s0, 1
	add $s1, $s1, 1
	add $s2, $s2, 1
	li $t1, 0
	li $t2, 0
	j encrypting
	
continue:
	li $v0, 4
	la $a0, answer1
	syscall
	
	la $a0, encrypt
	li $v0, 4
	syscall

	li $s0, 10
	la $s2, encrypt
	la $s3, decrypt
	
	la $a0, answer2
	li $v0, 4
	syscall
	
decrypting:
	beq $s0, $zero, end
	lb $t1, 0($s2)
	xor $t2, $t1, $t0
	sb $t2, 0($s3)
	sub $s0, $s0, 1
	add $s2, $s2, 1
	add $s3, $s3, 1
	li $t1, 0
	li $t2, 0
	j decrypting
	
end:
	# print the decrypted message
	la $a0, decrypt
	li $v0, 4
	syscall
	
	# exit the program
	li $v0, 10
	syscall
