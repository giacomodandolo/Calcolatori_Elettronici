# Ricerca del carattere minimo, vengono inseriti da tastiera 
# DIM valori, si calcola il minimo e si visualizza.

DIM=5
	.data
wValues:	.space 5
msg_in:	.asciiz "Inserisci i caratteri\n"
msg_out:	.asciiz "\nCarattere minimo: "

	.text
	.globl main
	.ent main
main:
	la $t0, wValues
	li $t1, 0
	li $v0, 4
	la $a0, msg_in
	syscall
	
insertCicle:	
	li $v0, 12
	syscall
	sb $v0, ($t0)
	addi $t1, 1
	addi $t0, 1
	bne $t1, DIM, insertCicle

	la $t0, wValues
	lb $t2, ($t0)
	li $t1, 0
minCicle:	
	lb $t3, ($t0)
	bgt $t3, $t2, notMin
	lb $t2, ($t0)
notMin:	
	addi $t1, $t1, 1
	addi $t0, $t0, 1
	bne $t1, DIM, minCicle
	
	li $v0, 4
	la $a0, msg_out
	syscall
	li $v0, 11
	la $a0, ($t2)
	syscall
	
	li $v0, 10
	syscall
	
	.end main