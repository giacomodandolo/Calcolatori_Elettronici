# Capire se una matrice è diagonale (2), simmetrica (1) o non simmetrica (0).

	.data
DIM 	= 6
NEXT_COL	= 4
NEXT_ROW	= 4 * DIM
NEXT	= 4 * (DIM + 1)
mat:	.word 1, 0, 1, 0, 0, 0
	.word 0, 1, 0, 0, 0, 0
	.word 0, 0, 1, 0, 0, 0
	.word 0, 0, 0, 1, 0, 0
	.word 0, 0, 0, 0, 1, 0
	.word 0, 0, 0, 0, 0, 1
	
	.text
	.globl main
	.ent main

main:	
	li $a0, 2		# ipotesi: è diagonale
	li $t7, 1		# contatore passaggio
	la $t1, mat		# carica riga
	la $t2, mat		# carica colonna
	add $t1, $t1, NEXT_COL
	add $t2, $t2, NEXT_ROW

wrapCycle:	
	move $t0, $t7		# carica pos attuale
	move $t3, $t1		# carica riga attuale
	move $t4, $t2		# carica colonna attuale
cycle:	
	lw $t5, ($t3)
	lw $t6, ($t4)
	bne $t5, $t6, notSimm	# se $t5 != $t6 -> non simmetrica
	
	addi $t0, $t0, 1
	addi $t3, $t3, NEXT_COL
	addi $t4, $t4, NEXT_ROW
	bne $t5, $0, simm	# se $t5 != 0 -> può essere simmetrica
	bne $t6, $0, simm	# se $t6 != 0 -> può essere simmetrica
	bne $t0, DIM, cycle
	
	addi $t7, $t7, 1
	addi $t1, $t1, NEXT
	addi $t2, $t2, NEXT
	bne $t7, DIM, wrapCycle
	j end
	
simm:
	la $a0, 1
	j cycle

notSimm:	
	la $a0, 0

end:
	li $v0, 1
	syscall

	li $v0, 10
	syscall
	.end main