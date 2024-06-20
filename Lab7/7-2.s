# Scrivere una procedura calcolaSucc che riceve tramite $a0 un numero
# naturale e calcoli l'elemento successivo della sequenza:
#
# c_{i+1} = 
#	c_i/2 	se c_i è pari 
#	3*c_i + 1	se c_i è dispari
#
# Tale numero è stampato a video e restituito attraverso $v0.


	.data
insertMsg:	.asciiz "Inserisci un numero c0: "
	.text
	.globl main
	.ent main

main:	
	subu $sp, 4		# utilizzato per concludere il programma
	sw $ra, ($sp)		# 
	
	li $v0, 4		# inserimento numero
	la $a0, insertMsg	#
	syscall		#
	li $v0, 5		#
	syscall		#
	
	move $a0, $v0		# ottieni valore
	jal calcolaSucc	# esegui procedura

	lw $ra, ($sp)		# termina programma
	addiu $sp, 4		#
	jr $ra		#
	.end main		#


	.ent calcolaSucc
calcolaSucc:
	and $t0, $a0, 1	# controlla se è pari o dispari
	beqz $t0, pari		# 
	
	mulou $t0, $a0, 3	# il numero è dispari
	addi $t0, $t0, 1	# 3c_i + 1
	j end		#
pari:	
	sra $t0, $a0, 1	# il numero è pari
			# c_i/2
end:	
	move $a0, $t0		# stampa valore 
	li $v0, 1		#
	syscall		#
	li $a0, '\n'		#
	li $v0, 11		#
	syscall		#
	
	move $v0, $t0		# restituisce $t0 attraverso $v0
	jr $ra		#
	.end calcoloSucc	#