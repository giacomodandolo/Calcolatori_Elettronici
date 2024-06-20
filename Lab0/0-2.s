# Scrittura di un valore in una cella di memoria.

	.data
wVar: 	.word 3

	.text
	.globl main
	.ent main

main:	
	li $t0, 10
	sw $t0, wVar
	
	li $v0, 10
	syscall
	
	.end main