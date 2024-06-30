# Lettura robusta di un numero intero.

	.data
startMsg:	.asciiz "Inserisci valori.\n\n"
successMsg:	.asciiz ": il carattere inserito è un numero.\n"
invalidMsg:	.asciiz ": il carattere inserito non è un numero.\n"
endProgram:	.asciiz "Termino il programma."
	.text
	.globl main
	.ent main

main:	
	la $a0, startMsg
	li $v0, 4
	syscall
	
loop:	
	li $v0, 12
	syscall
	beq $v0, '\n', exitLoop
	blt $v0, '0', invalidValue
	bgt $v0, '9', invalidValue
	
	la $a0, successMsg
	li $v0, 4
	syscall
	j loop
	
invalidValue:
	la $a0, invalidMsg
	li $v0, 4
	syscall
	j loop
	
exitLoop:
	la $a0, endProgram
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	.end main