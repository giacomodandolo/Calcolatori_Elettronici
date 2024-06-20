# Scrivere una procedura calSconto in MIPS in grado di calcolare il prezzo
# scontato degli articoli venduti in un negozio e salvarlo nel corrispondente
# elemento del vettore scontati.

	.data
NUM 	= 5
DIM 	= NUM * 4
SCONTO 	= 30
ARROTONDA 	= 0
prezzi:	.word 39, 1880, 2394, 1000, 1590
scontati:	.space DIM
totSconto: 	.space 4
	.text
	.globl main
	.ent main

main:	
	subu $sp, 4
	sw $ra, ($sp)
	
	la $a0, prezzi
	la $a1, scontati
	li $a2, NUM
	li $a3, SCONTO
	li $t0, ARROTONDA
	subu $sp, 4
	sw $t0, ($sp)
	jal calSconto
	
	sw $v0, totSconto
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, 4($sp)
	addiu $sp, 8
	jr $ra
	.end main
	
	.ent calSconto
calSconto:
	subu $fp, $sp, 4		# ottieni parametri necessari
	move $t0, $a0			# vettore prezzi
	move $t1, $a1			# vettore scontati
	move $t2, $0			# indice per ciclare
	li $t5, 100			# costante 100%
	sub $t3, $t5, $a3		# percentuale di prezzo rimanente
	lw $t4, 4($fp)			# arrotondamento
	move $v0, $0			# inizializzazione sconto totale
cycle:
	lw $t6, ($t0)			# ottieni prezzo i-esimo
	mul $t7, $t6, $t3		# moltiplica per percentuale di prezzo rimanente
	div $t7, $t5			# dividi per 100
	mflo $t7			# ottengo il prezzo scontato
	
	beqz $t4, noArr		# se ARROTONDA = 0, non arrotondare
	mfhi $t8			# ottieni resto
	blt $t8, 50, noArr		# se maggiore o uguale a 50, arrotonda
	addiu $t7, $t7, 1		# 
	
noArr:	sw $t7, ($t1)			# immagazzina il prezzo scontato
	subu $t8, $t6, $t7		# ottieni sconto applicato
	addu $v0, $v0, $t8		# somma sconto applicato allo sconto totale
	addiu $t0, $t0, 4
	addiu $t1, $t1, 4
	addiu $t2, $t2, 1
	bne $t2, $a2, cycle
	
	jr $ra
	.end calSconto
