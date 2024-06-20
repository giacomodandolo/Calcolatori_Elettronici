# Calcolare il prodotto di due matrici.

	.data
NUM_ELEM	= 4
DIM	= 4 * NUM_ELEM
vetRow:	.word 1, 2, 3, 4
vetCol:	.word 5, 6, 7, 8
matrixRes:	.space DIM * NUM_ELEM
overflowMsg:	.asciiz "Il programma restituisce overflow."
	.text
	.globl main
	.ent main

main:	
	li $t0, 0		# contatore matrixRes
	li $t1, 0		# contatore vetRow
	
cycleRow:	
	lw $t3, vetRow($t1)	# valore attuale (riga)
	li $t2, 0		# contatore vetCol
	
cycleCol:	
	lw $t4, vetCol($t2)	# valore attuale (colonna)
	mult $t3, $t4
	mfhi $t4
	beq $t4, 0, noOverflow
	bne $t4, 0, overflow
	
noOverflow:
	mflo $t4
	sw $t4, matrixRes($t0)	# carica in matrice
	addi $t0, $t0, 4
	addi $t2, $t2, 4
	blt $t2, DIM, cycleCol	# prossima colonna
	addi $t1, $t1, 4
	blt $t1, DIM, cycleRow	# finita riga
	j end
	
overflow:	
	la $a0, overflowMsg
	li $v0, 4
	syscall
	
end:
	li $v0, 10
	syscall
	.end main