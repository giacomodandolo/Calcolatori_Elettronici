# Calcolare i primi 20 valori della serie di Fibonacci

	.data
N_ELEM 	= 20
DIM 	= 4*N_ELEM
wVet:	.space DIM

	.text
	.globl main
	.ent main

main:	
	li $t0, 0		# contatore
	li $t1, 1		# FIB(0)
	sw $t1, wVet($t0)
	addi $t0, $t0, 4
	li $t2, 1		# FIB(1)
	sw $t1, wVet($t0)
	addi $t0, 4
	
cycle:	
	add $t3, $t1, $t2	# calcolo FIB(i)
	sw $t3, wVet($t0)	
	move $t1, $t2		# FIB(i-2) = FIB(i-1)
	move $t2, $t3		# FIB(i-1) = FIB(i)
	addi $t0, $t0, 4
	bne $t0, DIM, cycle
	
	li $v0, 10
	syscall
	.end main