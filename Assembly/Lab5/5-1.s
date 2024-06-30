# Stampare un intero unsigned su 32 bit.

	.data
number:	.word 3141592653
	.text
	.globl main
	.ent main

main:	
	lw $t0, number		# contiene il numero
	addi $t1, $0, 10	# divisore
	addi $t4, $0, 0	# contatore
	
divCycle:
	divu $t0, $t0, $t1
	mfhi $t2		# carica resto
	addi $t2, $t2, 0x30
	subu $sp, $sp, 4	# fai spazio nello stack
	sw $t2, ($sp)
	addi $t4, $t4, 1
	bne $t0, $0, divCycle
	
	move $t3, $sp
	li $v0, 11
printCycle:	
	lw $a0, ($t3)
	syscall
	addi $t3, 4
	sub $t4, $t4, 1
	bne $t4, $0, printCycle
	
	li $v0, 10
	syscall
	.end main