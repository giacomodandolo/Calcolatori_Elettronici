# Programma che conta il numero di bit a 1 nella rappresentazione binaria
# di una variabile di tipo halfword.

	.data
value:	.half 2002
countMsg:	.asciiz "Il numero di 1 nell'halfword vale: "

	.text
	.globl main
	.ent main

main:	
	and $t3, $0, $0	# azzero risultato
	and $t4, $0, $0	# azzero indice
	lh $t0, value		# carico la halfword
	li $t1, 1		# creo la maschera per contare

loop:	
	and $t2, $t0, $t1
	beq $t2, 0, notOne
	addi $t3, $t3, 1
notOne:	
	sll $t1, $t1, 1
	addi $t4, $t4, 1
	bne $t4, 16, loop

	la $a0, countMsg
	li $v0, 4
	syscall
	move $a0, $t3
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	.end main