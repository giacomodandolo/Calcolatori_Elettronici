# Scrivere una procedura che calcoli, in una matrice di byte contenente numeri senza segno,
# la somma dei valori contenuti nelle celle adiacenti ad una determinata cella.

RIGHE 	= 4
COLONNE 	= 5
	.data
matrice:	.byte 0, 1, 3, 6, 2
	.byte 7, 13, 20, 12, 21
	.byte 11, 22, 10, 23, 9
	.byte 24, 8, 25, 43, 62
	.text
	.globl main
	.ent main

main:	
	subu $sp, 4
	sw $ra, ($sp)
	
	la $a0, matrice
	li $a1, 4
	li $a2, RIGHE
	li $a3, COLONNE
	jal contaVicini
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, ($sp)
	addiu $sp, 4
	jr $ra
	.end main
	
	
	.ent contaVicini
contaVicini:	
	div $a1, $a3
	mflo $t0		# indice riga
	mfhi $t1		# indice colonna
	li $v0, 0
rowAbove:			# imposta il limite agli indici
	addi $t2, $t0, -1	#
	bne $t2, -1, rowBelow	# 
	li $t2, 0		# $t2 = indice riga superiore
rowBelow:			# 
	addi $t3, $t0, 1	#
	bne $t3, $a2, colLeft	#
	sub $t3, $a2, 1	# $t3 = indice riga inferiore
colLeft:			#
	addi $t4, $t1, -1	#
	bne $t4, -1, colRight	#
	li $t4, 0		# $t4 = indice colonna sinistra
colRight:			#
	addi $t5, $t1, 1	#
	bne $t5, $a3, cellIndex	#
	sub $t5, $a3, 1	# $t5 = indice colonna destra
cellIndex:	
	mul $t1, $t2, $a3	# riga superiore
	add $t0, $t1, $t4	# riga superiore SX
	add $t1, $t1, $t5	# riga superiore DX
	
	mul $t2, $t3, $a3	# riga inferiore
	add $t2, $t2, $t4	# riga inferiore SX
	
	add $t0, $t0, $a0	# indirizzi tradotti nella matrice
	add $t1, $t1, $a0	#
	add $t2, $t2, $a0	#
	add $a1, $a1, $a0	#
extCycle:
	move $t3, $t0
intCycle:
	beq $t3, $a1, skip	# se centrale, skip
	lb $t4, ($t3)		# altrimenti somma
	add $v0, $v0, $t4	#
skip:
	add $t3, $t3, 1
	bleu $t3, $t1, intCycle	
	add $t0, $t0, $a3	# se fine riga, prossima
	add $t1, $t1, $a3	#
	bleu $t0, $t2, extCycle	#
	
	jr $ra
	.end contaVicini
	