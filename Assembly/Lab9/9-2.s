# Scrivere una procedura sostituisci in grado di espandere una stringa precedentemente
# inizializzata sostituendo tutte le occorrenze del carattere % con un'altra stringa data.

	.data
str_orig:	.asciiz "% nella citta' dolente, % nell'eterno dolore, % tra la perduta gente"
str_sost:	.asciiz "per me si va"
str_new:	.space 200
	.text
	.globl main
	.ent main

main:	
	subu $sp, 4
	sw $ra, ($sp)
	
	la $a0, str_orig
	la $a1, str_sost
	la $a2, str_new
	jal sostituisci
	
	la $a0, str_new
	li $v0, 4
	syscall
	
	lw $ra, ($sp)
	addiu $sp, 4
	jr $ra
	.end main
	
	
	.ent sostituisci
sostituisci:	
	li $t2, 0x00
cycle:	
	lb $t0, 0($a0)			# ottieni carattere prima stringa
	bne $t0, '%', notSub		# controlla se carattere da sostituire
	
	move $t1, $a1			# ottieni indirizzo seconda stringa
cycleSub:	
	lb $t3, 0($t1)			# ottieni carattere stringa da inserire
	sb $t3, 0($a2)			# carica carattere
	addiu $a2, $a2, 1		# 
	
	addiu $t1, $t1, 1
	lb $t4, 0($t1)			# controlla se prossimo carattere
	bne $t4, $t2, cycleSub		# è terminatore
	j recycle
notSub:	
	sb $t0, ($a2)			# carica carattere
	addiu $a2, $a2, 1		#

recycle:	
	addiu $a0, $a0, 1
	lb $t4, 0($a0)			# controlla se prossimo carattere
	bne $t4, $t2, cycle		# è terminatore
	
	jr $ra
	.end sostituisci
