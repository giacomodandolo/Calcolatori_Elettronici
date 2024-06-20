# Scrivere una procedura costoPar per calcolare il costo di un parcheggio.
#
# Il costo di un parcheggio è pari a X euro per ogni periodo di Y minuti.
# Per eventuali minuti di un periodo non completo sono addebitati comunque X euro.
#
# Per la differenza sui minuti, ricordarsi di usare unsigned.

	.data
timeIn:	.byte 12, 47
timeOut:	.byte 18, 14
X:	.byte 1
Y:	.byte 40
	.text
	.globl main
	.ent main
main:	
	subu $sp, 4
	sw $ra, ($sp)
	
	la $a0, timeIn
	la $a1, timeOut
	lbu $a2, X
	lbu $a3, Y
	jal costoPar
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, ($sp)
	addiu $sp, 4
	jr $ra
	.end main
	
	
	.ent costoPar
costoPar:	
	lbu $t0, 0($a0)		# ora inizio
	lbu $t1, 0($a1)		# ora fine
	
	subu $t0, $t1, $t0		# calcolo minuti da ore
	li $t1, 60			#
	multu $t0, $t1			#
	
	lbu $t0, 1($a0)		# minuto inizio
	lbu $t1, 1($a1)		# minuto fine
	subu $t0, $t1, $t0		# calcolo minuti
	
	mflo $t1			# calcolo totale minuti
	addu $t0, $t0, $t1		#
	
	divu $t0, $a3			# calcolo numero periodi
	mflo $t0			#
	mfhi $t1			#
	beqz $t1, endProc		# se resto != 0, aggiungi 1 periodo
	addiu $t0, $t0, 1		#
	
endProc:	multu $t0, $a2			# calcolo euro
	mflo $v0			#
	
	jr $ra
	.end costoPar
