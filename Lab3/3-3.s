# Calcolare il numero totale di minuti passato da un certo istante T0,
# definito da days, hours e minutes.
#
# Notare come matematicamente non è possibile avere overflow.

	.data
days:	.byte 255
hours:	.byte 255
minutes:	.byte 255
result:	.word 0

	.text
	.globl main
	.ent main

main:	
	lbu $t0, days
	lbu $t1, hours
	lbu $t2, minutes
	li $t3, 1440		# constant days -> minutes
	li $t4, 60		# constant hours -> minutes
	
	mult $t0, $t3		# conversion days -> minutes
	mflo $t0
	add $t2, $t2, $t0
	
	mult $t1, $t4		# conversion hours -> minutes
	mflo $t1
	add $t2, $t2, $t1
	
	sw $t2, result		# storing result 
	
	lw $a0, result
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	.end main