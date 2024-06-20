# Scrivere una procedura det2x2 per calcolare il valore 
# del determinante di una matrice quadrata 2x2.

	.data
mat:	.word 1, 2, 3, 4
outputMsg:	.asciiz "Il determinante vale: "
	.text
	.globl main
	.ent main

main:	
	subu $sp, 4
	sw $ra, ($sp)
	
	la $t0, mat		# carica valori per la procedura
	lw $a0, ($t0)		# 
	lw $a1, 4($t0)		#
	lw $a2, 8($t0)		#
	lw $a3, 12($t0)	#
	
	jal det2x2
	
	move $t0, $v0		# stampa valore determinante
	li $v0, 4		#
	la $a0, outputMsg	#
	syscall		#
	li $v0, 1		#
	move $a0, $t0		#
	syscall		#
	
	lw $ra, ($sp)
	addiu $sp, 4
	jr $ra
	.end main
	

	.ent det2x2
det2x2:	
	move $t0, $a0
	move $t1, $a1
	
	mul $t0, $t0, $a3
	mul $t1, $t1, $a2
	sub $v0, $t0, $t1
	
	jr $ra
	.end det2x2