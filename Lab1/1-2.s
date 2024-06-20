# Converti in maiuscolo le prime 4 variabili e stampa la relativa stringa

	.data
var1:	.byte 'm'
var2:	.byte 'i'
var3:	.byte 'p'
var4:	.byte 's'
var5:	.byte 0

	.text
	.globl main
	.ent main	
main:
	li $t1, 'a'
	li $t2, 'A'
	sub $t3, $t1, $t2
	
	lb $t0, var1
	sub $t0, $t0, $t3
	sb $t0, var1
	
	lb $t0, var2
	sub $t0, $t0, $t3
	sb $t0, var2
	
	lb $t0, var3
	sub $t0, $t0, $t3
	sb $t0, var3
	
	lb $t0, var4
	sub $t0, $t0, $t3
	sb $t0, var4
	
	la $a0, var1
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	
	.end main