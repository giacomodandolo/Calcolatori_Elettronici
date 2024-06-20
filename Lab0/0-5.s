# Somma di elementi di un vettore tramite loop.

DIM=4
	.data
wVett:	.word 5, 7, 3, 4
wResult:	.space 4

	.text
	.globl main
	.ent main
main:
	li $t1, 0
	li $t3, 0
	la $t0, wVett
	
cicle:	lw $t2, ($t0)
	add $t1, $t1, $t2
	addi $t0, 4
	addi $t3, 1
	bne $t3, DIM, cicle
	
	sw $t1, wResult
	
	li $v0, 10
	syscall
	
	.end main