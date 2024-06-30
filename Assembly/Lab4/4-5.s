# Data una tabella, calcolare la somma delle colonne e delle righe.

	.data
NUM_ROW	= 4
NUM_COL	= 6
DIM_ROW	= 4 * NUM_COL
matrixRes:	.word 	154, 123, 109, 86, 4, 0, 412, -23, -231, 9, 50, 0, 123, -24, 12, 55, -45, 0, 0, 0, 0, 0, 0, 0
	.text
	.globl main
	.ent main

main:	
	li $t0, 0		# offset matrice (sum row)
	li $t1, 1		# contatore righe
cycleSumRow:	
	li $t2, 1		# contatore colonne
	li $t3, 0		# somma valori riga 
cycleRowCol:
	lw $t4, matrixRes($t0)
	add $t3, $t3, $t4
	addi $t0, $t0, 4
	addi $t2, $t2, 1
	blt $t2, NUM_COL, cycleRowCol
	sw $t3, matrixRes($t0)
	addi $t1, $t1, 1
	addi $t0, $t0, 4
	blt $t1, NUM_ROW, cycleSumRow


	li $t0, 0		# offset matrice (sum col)
	li $t2, 1		# contatore colonne
cycleSumCol:
	li $t1, 1		# contatore righe
	li $t3, 0		# somma valori colonna
cycleColRow:
	lw $t4, matrixRes($t0)
	add $t3, $t3, $t4
	addi $t0, $t0, DIM_ROW
	addi $t1, $t1, 1
	blt $t1, NUM_ROW, cycleColRow
	sw $t3, matrixRes($t0)
	sll $t0, $t2, 2
	addi $t2, $t2, 1
	blt $t2, NUM_COL, cycleSumCol


	li $v0, 10
	syscall
	.end main