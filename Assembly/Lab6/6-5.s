# Creare una procedura che permette di calcolare una combinazione semplice.

	.data
msgN:	.asciiz "n: "
msgK:	.asciiz "k: "
msgC:	.asciiz "C = "
	.text
	.globl main
	.ent main

main:
	li $v0, 4
	la $a0, msgN
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, msgK
	syscall
	li $v0, 5
	syscall
	
	move $a0, $t0
	move $a1, $v0
	jal combina
	
	move $t0, $v0
	li $v0, 4
	la $a0, msgC
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall
	.end main
	
	
# Calcola la combinazione semplice C(n,k).
# $a0: n
# $a1: k
# $v0: risultato
combina:
	subu $t0, $a0, $a1	# n - k
	addu $t0, $t0, 1
	move $v0, $t0
cycleNum:	
	beq $a0, $t0, nextStep
	addu $t0, $t0, 1
	mul $v0, $v0, $t0
	j cycleNum

nextStep:	
	move $t0, $a1
cycleDen:	
	divu $v0, $v0, $t0
	sub $t0, $t0, 1
	bltu $t0, 1, end
	j cycleDen
	
end:	jr $ra
.end combina