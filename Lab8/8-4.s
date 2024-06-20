# Si scriva una procedura distanzaH che calcoli la distanza di Hamming binaria
# tra gli elementi di indice corrispondente di due vettori di word di lunghezza DIM.


	.data
DIM = 	5
vet1:	.word 56, 12, 98, 129, 58
vet2:	.word 1, 0, 245, 129, 12
risultato:	.space 20
	.text
	.globl main
	.ent main

main:	
	subu $sp, 4
	sw $ra, ($sp)
	
	la $a0, vet1
	la $a1, vet2
	la $a2, risultato
	li $a3, DIM
	
	jal distanzaH
	
	li $t0, 0
	li $v0, 1
	la $t1, risultato
printCycle:	
	lb $a0, ($t1)
	syscall
	addiu $t1, $t1, 1
	addiu $t0, $t0, 1
	bne $t0, DIM, printCycle
	
	lw $ra, ($sp)
	addiu $sp, 4
	jr $ra
	.end main
	
	.ent distanzaH
distanzaH:	
	li $t0, 0
cycle:	
	beq $t0, $a3, endCycle
	
	lw $t1, ($a0)		# carica parola vet1
	lw $t2, ($a1)		# carica parola vet2
	xor $t3, $t1, $t2	# esegui xor
	li $t4, 0		# azzeramento risultato
	li $t5, 0		# azzeramento indice
	li $t6, 1		# maschera per lettura bit a 1
cycleH:	
	and $t7, $t3, $t6	
	beq $t7, 0, nextH
	addiu $t4, $t4, 1
nextH:	
	sll $t6, $t6, 1
	addiu $t5, $t5, 1
	bne $t5, 32, cycleH
	
	sb $t4, ($a2)
	addiu $t0, $t0, 1
	addiu $a0, $a0, 4
	addiu $a1, $a1, 4
	addiu $a2, $a2, 1
	
	j cycle
endCycle:	
	jr $ra
	.end distanzaH