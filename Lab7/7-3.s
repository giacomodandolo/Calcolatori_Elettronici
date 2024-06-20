# Sfruttando la funzione calcolaSucc, scrivere
# una procedura seqCollatz, con cui calcolare il numero
# di elementi necessari per ottenere il numero 1.
# (Congettura di Collatz)

	.data
insertMsg:	.asciiz "Inserisci un numero c0: "
outputMsg:	.asciiz "Numeri di elementi nella sequenza: "
	.text
	.globl main
	.ent main

main:	
	subu $sp, 4		# utilizzato per concludere il programma
	sw $ra, ($sp)		# 
	
	li $v0, 4		# inserimento numero
	la $a0, insertMsg	#
	syscall		#
	li $v0, 5		#
	syscall		#
	
	move $a0, $v0		# ottieni valore
	jal seqCollatz		# esegui procedura

	move $t0, $v0		# stampa numero di elementi
	li $v0, 4		#
	la $a0, outputMsg	#
	syscall		#
	move $a0, $t0		#
	li $v0, 1		#
	syscall		#

	lw $ra, ($sp)		# termina programma
	addiu $sp, 4		#
	jr $ra		#
	.end main		#


	.ent seqCollatz
seqCollatz:
	subu $sp, 8		# salva $ra e $s0
	sw $ra, 4($sp)		#
	sw $s0, ($sp)		#
	li $s0, 1		# contatore valori
cycle:	
	beq $a0, 1, endSeq	# se $a0 = 1, termina procedura
	jal calcolaSucc	# calcola successivo
	move $a0, $v0		#
	addi $s0, $s0, 1	#
	j cycle		#
endSeq:	
	move $v0, $s0		#
	lw $s0, ($sp)		# ristora $s0
	lw $ra, 4($sp)		# termina programma
	addiu $sp, 8		#
	jr $ra		#
	.end seqCollatz	#


	.ent calcolaSucc
calcolaSucc:
	and $t0, $a0, 1	# controlla se è pari o dispari
	beqz $t0, pari		# 
	
	mulou $t0, $a0, 3	# il numero è dispari
	addi $t0, $t0, 1	# 3c_i + 1
	j endSucc		#
pari:	
	sra $t0, $a0, 1	# il numero è pari
			# c_i/2
endSucc:	
	move $a0, $t0		# stampa valore 
	li $v0, 1		#
	syscall		#
	li $a0, '\n'		#
	li $v0, 11		#
	syscall		#
	
	move $v0, $t0		# restituisce $t0 attraverso $v0
	jr $ra		#
	.end calcoloSucc	#