# Scrivere una procedura det3x3 per calcolare il valore 
# del determinante di una matrice quadrata 3x3.
# Si sfrutti la procedura det2x2.

	.data
mat:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9
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
	
	li $t1, 0		# indice cycleStack
cycleStack:	
	lw $t2, 16($t0)	# inserisci gli argomenti da 5 a 9 
	subu $sp, 4		# nello stack
	sw $t2, ($sp)		#
	addiu $t1, $t1, 1	#
	addiu $t0, $t0, 4	#
	bne $t1, 5, cycleStack	#
	
	jal det3x3		# esegui procedura
	
	move $t0, $v0		# stampa valore determinante
	li $v0, 4		#
	la $a0, outputMsg	#
	syscall		#
	li $v0, 1		#
	move $a0, $t0		#
	syscall		#
	
	addiu $sp, 20
	lw $ra, ($sp)
	addiu $sp, 4
	jr $ra
	.end main
	
	
	.ent det3x3
det3x3:
	subu $fp, $sp, 4	# utilizzato per argomenti da 5 a 9
	
	subu $sp, 20		# salva $s0-$s3 e $ra
	sw $s0, ($sp)		#
	sw $s1, 4($sp)		#
	sw $s2, 8($sp)		#
	sw $s3, 12($sp)	#
	sw $ra, 16($sp)	#

	move $s0, $a0		# carica argomenti da 1 a 4
	move $s1, $a1		#
	move $s2, $a2		#
	move $s3, $a3		#
			
	lw $a0, 20($fp)	# carica b2, c2, b3, c3
	lw $a1, 16($fp)	#
	lw $a2, 8($fp)		#
	lw $a3, 4($fp)		#
	jal det2x2		# esegui procedura
	mul $s0, $s0, $v0	# carica primo risultato
	
	move $a0, $s3		# carica a2, b2, a3, b3
	lw $a1, 16($fp)	#
	lw $a2, 12($fp)	#
	lw $a3, 4($fp)		#
	jal det2x2		# esegui procedura
	mul $s1, $s1, $v0	# carica secondo risultato
	
	move $a0, $s3		# carica a2, b2, a3, b3
	lw $a1, 20($fp)	#
	lw $a2, 12($fp)	#
	lw $a3, 8($fp)		#
	jal det2x2		# esegui procedura
	mul $s2, $s2, $v0	# carica terzo risultato
	
	add $v0, $s0, $s2	# calcola determinante 3x3
	sub $v0, $v0, $s1	#
	
	lw $s0, ($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $ra, 16($sp)
	addiu $sp, 20
	jr $ra
	.end det3x3


	.ent det2x2
det2x2:	
	mul $t0, $a0, $a3
	mul $t1, $a1, $a2
	sub $v0, $t0, $t1
	
	jr $ra
	.end det2x2