# Acquisire DIM valori word e calcolare la media (intera).
DIM = 10
	.data
startMsg:	.asciiz "Inserisci 10 valori.\n"
meanMsg:	.asciiz "La media vale: "
	.text
	.globl main
	.ent main

main:	
	and $t0, $0, $0	# contatore
	and $t1, $0, $0	# accumulatore
	
	la $a0, startMsg
	li $v0, 4
	syscall
loop:	
	li $v0, 5
	syscall
	
	add $t1, $t1, $v0
	addi $t0, $t0, 1
	
	bne $t0, DIM, loop
	
	la $a0, meanMsg
	li $v0, 4
	syscall
	
	div $t1, $t1, DIM
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	.end main