# Somma degli elementi di un vettore tramite somme successive.

	.data
wVett:	.word 5, 7, 3, 4, 3
wResult:	.space 4

	.text
	.globl main
	.ent main
main:
	li $t1, 0
	la $t0, wVett
	
	lw $t2, ($t0)
	add $t1, $t1, $t2
	addi $t0, 4
	
	lw $t2, ($t0)
	add $t1, $t1, $t2
	addi $t0, 4
	
	lw $t2, ($t0)
	add $t1, $t1, $t2
	addi $t0, 4
	
	lw $t2, ($t0)
	add $t1, $t1, $t2
	addi $t0, 4
	
	lw $t2, ($t0)
	add $t1, $t1, $t2
	addi $t0, 4
	
	sw $t1, wResult
	
	li $v0, 10
	syscall
	
	.end main