# Scrivere un programma per capire se un'equazione di
# secondo grado abbia o meno soluzioni reali.
#
#	ax^2 + bx + c = 0

	.data
msgInput:	.asciiz "Inserisci i valori di a,b,c: "
msgNoSol:	.asciiz "Non sono presenti soluzioni reali."
msgOneSol:	.asciiz "E' presente una soluzione reale."
msgTwoSol:	.asciiz "Sono presenti due soluzioni reali."

	.text
	.globl main
	.ent main

main:	
	li $v0, 4
	la $a0, msgInput
	syscall
	
	li $v0, 5		# a
	syscall
	move $t0, $v0
	
	li $v0, 5		# b
	syscall
	move $t1, $v0
	
	li $v0, 5		# c
	syscall
	move $t2, $v0
	
	mul $t3, $t1, $t1	# b^2
	mul $t4, $t0, $t2	# ac
	sll $t4, $t4, 2	# 4ac
	sub $t5, $t3, $t4	# b^2 - 4ac
	beq $t5, $0, oneSol
	slt $t6, $t5, $0
	beq $t6, 1, noSol
	j twoSol
	
noSol:	
	li $v0, 4
	la $a0, msgNoSol
	syscall
	j end
	
oneSol:	
	li $v0, 4
	la $a0, msgOneSol
	syscall
	j end

twoSol:	
	li $v0, 4
	la $a0, msgTwoSol
	syscall
	
	
end:
	li $v0, 10
	syscall
	.end main