# Date 3 variabili word inizializzate, stamparle in ordine crescente.

	.data
varA:	.word -10
varB:	.word 5
varC:	.word 20
space:	.asciiz "; "
	.text
	.globl main
	.ent main

main:	
	lw $t0, varA
	lw $t1, varB
	lw $t2, varC
	
	
	blt $t0, $t1, jump1
	move $t3, $t0
	move $t0, $t1
	move $t1, $t3
	
jump1:	
	blt $t0, $t2, jump2
	move $t3, $t0
	move $t0, $t2
	move $t2, $t3

jump2:	
	blt $t1, $t2, jump3
	move $t3, $t1
	move $t1, $t2
	move $t2, $t3

jump3:	
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	
	move $a0, $t1
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	
	move $a0, $t2
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	.end main