# Si abbia un vettore contenente alcuni interi rappresentanti anni passati (da 0 a 2023).
# Si scriva una procedura bisestile che sia in grado di determinare se tali anni sono bisestili.

	.data
LENGTH 	= 6
anni:	.word 1945, 2008, 1800, 2006, 1748, 1600
risultato:	.space LENGTH
	.text
	.globl main
	.ent main

main:	
	subu $sp, 4
	sw $ra, ($sp)
	
	la $a0, anni
	la $a1, risultato
	li $a2, LENGTH
	
	jal bisestile
	
	la $t1, risultato
	li $t2, LENGTH
	
printCycle:			
	li $v0, 1		# stampo valori risultato
	lbu $a0, ($t1)		#
	syscall		#
	addiu $t1, $t1, 1	#
	subu $t2, $t2, 1	#
	bnez $t2, printCycle	#
	
	lw $ra, ($sp)
	addiu $sp, 4
	jr $ra
	.end main
	
	
	.ent bisestile
bisestile:	
bisCycle:
	sb $0, ($a1)		# ipotizzo non bisestile
	lw $t0, ($a0)		# carico anno
	
	li $t1, 100		# controllo divisibilità per 100
	divu $t0, $t1		#
	mfhi $t1		#
	bnez $t1, not100	# se no, allora controllare divisibilità per 4
	
	li $t1, 400		# controllo divisibilità per 400
	divu $t0, $t1		#
	mfhi $t1		#
	bnez $t1, nextCycle	# se no, allora controlla prossimo anno
	li $t1, 1		# se si, allora è bisestile
	sb $t1, ($a1)		#
	j nextCycle		#
not100:	
	li $t1, 4		# controllo divisibilità per 4
	divu $t0, $t1		#
	mfhi $t1		#
	bnez $t1, nextCycle	# se no, allora controllo prossimo anno
	li $t1, 1		# se si, allora è bisestile
	sb $t1, ($a1)		#

nextCycle:	
	addiu $a0, 4
	addiu $a1, 1
	subu $a2, 1
	bnez $a2, bisCycle
	
	jr $ra
	.end bisestile
