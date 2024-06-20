# Lettura robusta di un numero intero. 
# Controllare se rappresentabile su 4 byte.

	.data
startMsg:	.asciiz "Inserisci valori.\n\n"
successMsg:	.asciiz ": il carattere inserito è un numero.\n"
invalidMsg:	.asciiz ": il carattere inserito non è un numero.\n"
insertedMsg:	.asciiz "Valore inserito: "
nByteMsg:	.asciiz "\nIl numero non è rappresentabile su 4 byte."
yByteMsg:	.asciiz "\nIl numero è rappresentabile su 4 byte."

	.text
	.globl main
	.ent main

main:	
	la $a0, startMsg
	li $v0, 4
	syscall
	li $t0, 0		# result
	li $t3, 10		# constant
	
loop:	
	li $v0, 12
	syscall
	beq $v0, '\n', exitLoop
	blt $v0, '0', invalidValue
	bgt $v0, '9', invalidValue
	
	move $t1, $v0
	sub $t1, $t1, '0'
	mult $t0, $t3
	mfhi $t2
	bne $t2, $0, noByte
	mflo $t0
	add $t0, $t1, $t0
	
	la $a0, successMsg
	li $v0, 4
	syscall
	
	j loop
	
invalidValue:
	la $a0, invalidMsg
	li $v0, 4
	syscall
	j exitLoop

noByte:	
	la $a0, nByteMsg
	li $v0, 4
	syscall
	j endProgram
		
exitLoop:
	la $a0, insertedMsg
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
	
yesByte:	
	la $a0, yByteMsg
	li $v0, 4
	syscall

endProgram:
	li $v0, 10
	syscall
	.end main