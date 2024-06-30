# Scrivere una procedura in grado di calcolare il valore massimo di
# un vettore di interi word e stamparlo nel main.

	.data
DIM 	= 7
vett:	.word 15, 870, 1200, -21, -1000, 15003, -1039581
	.text
	.globl main
	.ent main

main:	
	la $a0, vett
	li $a1, DIM
	jal massimo
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	.end main
	

# Determina il massimo in un vettore di interi word.
# $a0: parametro indirizzo vettore
# $a1: parametro lunghezza
# $v0: risultato ritornato
massimo:	
	move $t0, $a0
	move $t1, $a1
	lw $v0, ($t0)		# ipotesi: primo valore è il massimo
	
cycle:	add $t0, $t0, 4
	sub $t1, $t1, 1
	beqz $t1, end
	lw $t2, ($t0)
	blt $t2, $v0, nextValue
	move $v0, $t2

nextValue:	j cycle

end:	jr $ra
.end massimo
