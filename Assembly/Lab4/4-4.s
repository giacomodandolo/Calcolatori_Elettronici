# Scrivere un programma che genera una tavola pitagorica 10x10. 

	.data
N_ELEM	= 10
DIM	= 4 * N_ELEM
table:	.space DIM*N_ELEM
	.text
	.globl main
	.ent main

main:	
	li $t0, 0
	li $t1, 1
cycleRow:	
	li $t2, 1
cycleCol:	
	multu $t1, $t2
	mflo $t3
	sw $t3, table($t0)
	addi $t0, $t0, 4
	addi $t2, $t2, 1
	ble $t2, N_ELEM, cycleCol
	addi $t1, $t1, 1
	ble $t1, N_ELEM, cycleRow
	
	li $v0, 10
	syscall
	.end main