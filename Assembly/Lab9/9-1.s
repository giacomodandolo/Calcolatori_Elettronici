# Calcolare la variazione percentuale tra gli elementi di indice corrispondente
# alla riga l della prima matrice e della colonna l della seconda.
#
# Variazione = [(Val2 - Val1) * 100] / Val1

	.data
DIM	= 3
DIM_ROW	= 4 * DIM
firstMat:	.word 4, -45, 15565
	.word 6458, 4531, 124
	.word -548, 2124, 31000
	
secondMat:	.word 6, -5421, -547
	.word -99, 4531, 1456
	.word 4592, 118, 31999
	
result:	.space DIM_ROW
l:	.byte 2
spaceChar:	.asciiz " "

	.text
	.globl main
	.ent main

main:	
	subu $sp, 4
	sw $ra, ($sp)
	
	la $a0, firstMat
	la $a1, secondMat
	la $a2, result
	li $a3, DIM
	lb $t0, l 
	subu $sp, 4
	sw $t0, ($sp)
	
	jal variazione
	
	addiu $sp, 4
	la $t0, result
	li $t1, 0
cyclePrint:	
	li $v0, 1
	lw $a0, ($t0)
	syscall
	li $v0, 4
	la $a0, spaceChar
	syscall
	addi $t1, $t1, 1
	addiu $t0, $t0, 4
	bne $t1, DIM, cyclePrint
	
	lw $ra, ($sp)
	addiu $sp, 4
	jr $ra
	.end main
	
	
	.ent variazione
variazione:	
	move $fp, $sp			
	lb $t0, 0($fp)			# carico l
	li $t1, 100			# costante per 100
	li $t7, 0			# contatore cycle
	
	mul $t2, $t0, DIM_ROW		# spostamento indice iniziale prima matrice
	addu $a0, $a0, $t2		#
	
	mul $t2, $t0, 4
	addu $a1, $a1, $t2		# spostamento indice iniziale seconda matrice
	
cycle:
	lw $t3, 0($a0)			# carica elemento prima matrice
	lw $t4, 0($a1)			# carica elemento seconda matrice
	
	sub $t5, $t4, $t3		# calcola variazione
	mul $t5, $t5, $t1		#
	div $t5, $t3			#
	
	mflo $t6			# carica variazione in result
	sw $t6, ($a2)			#
	
	addiu $a0, $a0, 4
	addiu $a1, $a1, DIM_ROW
	addiu $a2, $a2, 4
	addiu $t7, $t7, 1
	bne $t7, DIM, cycle

	jr $ra
	.end variazione