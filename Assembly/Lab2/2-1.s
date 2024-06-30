# Richiedi un intero positivo all'utente e determina se è pari o dispari.

	.data
requestPrint:	.asciiz "Inserisci un numero intero positivo: "
evenPrint:	.asciiz "Pari"
oddPrint:	.asciiz "Dispari"
	.text
	.globl main
	.ent main

main:	
	li $v0, 4
	la $a0, requestPrint
	syscall
	li $v0, 5
	syscall
	andi $t0, $v0, 1
	la $a0, evenPrint
	beq $t0, $zero, evenLabel
	la $a0, oddPrint

evenLabel:	
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	.end main