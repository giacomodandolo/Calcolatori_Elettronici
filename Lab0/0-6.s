# Lettura da tastiera e visualizzazione a video di 
# un vettore di 5 caratteri.

DIM=4
	.data
wVett:	.space 20
msg_in:	.asciiz "Inserire numeri\n"	# con .asciiz viene aggiunto il valore NULL
			# al termine della stringa, necessario per
			# la stampa.
msg_out:	.asciiz "Numeri inseriti\n"
space:	.ascii " "

	.text
	.globl main
	.ent main

main:	la $t0, wVett		# carica inizio wVett in $t0
	li $t1, 0		# contatore
	li $v0, 4		# stampa stringa
	la $a0, msg_in		#
	syscall		#
	
	
getCicle:	li $v0, 5		# ottieni interi
	syscall		#	
	sw $v0, ($t0)		# metti intero su wVett
	beq $t1, DIM, printNum
	addi $t1, 1
	addi $t0, 4
	j getCicle
	
printNum:	li $v0, 4		# stampa stringa
	la $a0, msg_out	#
	syscall		#
	
	la $t0, wVett
	li $t1, 0
printCicle:	li $v0, 1		# stampa interi
	lw $a0, ($t0)		#
	syscall		#
	beq $t1, DIM, endProg	#
	li $v0, 4		#
	la $a0, space		#
	syscall		#
	addi $t0, 4		#
	addi $t1, 1		#
	j printCicle		#
	
endProg:	nop
	
	li $v0, 10
	syscall
	
	.end main