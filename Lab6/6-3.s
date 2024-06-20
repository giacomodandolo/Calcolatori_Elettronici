# Conversione di una parola di caratteri minuscoli in caratteri maiuscoli,
# attraverso una procedura.

	.data
DIM	= 6
stringa:	.ascii "parola"
	.text
	.globl main
	.ent main

main:	
	li $t0, 0
cycle:
	lbu $a0, stringa($t0)
	jal converti
	sb $v0, stringa($t0)
	addi $t0, $t0, 1
	bne $t0, DIM, cycle
	
	la $a0, stringa
	li $v0, 4
	syscall

	li $v0, 10
	syscall
	.end main
	
	
# Converti un carattere minuscolo in carattere maiuscolo.
# $a0: parametro by value
# $v0: carattere restituito
converti:
	addi $a0, $a0, 'A'
	li $v0, 'a'
	sub $v0, $a0, $v0
	jr $ra
.end converti