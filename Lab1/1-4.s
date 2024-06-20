# Si memorizzi nel registro $t1 il doppio del valore di var e poi lo si stampi a video.
# Aggiungere a $t1 il valore immediato 40 (usando un altro registro come destinazione
# per non modificare $t1).
# Ripetere l’operazione precedente, ma questa volta porre 40 nel registro $t2 e poi sommare 
# $t1 e $t2.

	.data
var:	.word 0x3FFFFFF0

	.text
	.globl main
	.ent main	
main:
	lw $t0, var
	add $t1, $t0, $t0
	
	move $a0, $t1
#	li $v0, 1
#	syscall
	
#	addi $a0, $t1, 40	# causa eccezione di overflow
#	addiu $a0, $t1, 40
#	li $v0, 1
#	syscall
	
#	add $a0, $t1, $t2	# causa eccezione di overflow
	li $t2, 40
	addu $a0, $t1, $t2
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	.end main