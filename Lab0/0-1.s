# Scrittura di un valore in un registro e sua verifica su QtSpim.

	.data
	
	.text
	.globl main
	.ent main
main:
	li $t0, 10
	li $s0, 0xDC
	
	li $v0, 10
	syscall
	
	.end main