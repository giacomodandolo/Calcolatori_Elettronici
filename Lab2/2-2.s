# Acquisire due interi positivi ed eseguire l'operazione C
# C = NOT(A AND (NOT(B))) OR (A XOR B)

	.data
errorMsg:	.asciiz "I valori inseriti non sono validi."
successMsg:	.asciiz "L'operazione logica bitwise sull'operazione inserita vale: "
insertMsg:	.asciiz "Inserisci due valori interi positivi.\n"

	.text
	.globl main
	.ent main

main:	
	la $a0, insertMsg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	li $t1, 0xFFFFFF00 	# uso maschera per controllare se 
			# rappresentabile in 1 byte
	and $t0, $v0, $t1
	bne $t0, 0, error	# se valore preso da maschera non è
			# 0, il valore è più grande di 1 byte
	move $t0, $v0

	li $v0, 5		# analogo per il secondo numero
	syscall
	and $t1, $v0, $t1
	bne $t1, 0, error
	move $t1, $v0

	not $t2, $t1		# NOT(B)
	and $t2, $t2, $t0	# A AND (NOT(B))
	not $t2, $t2		# NOT(A AND (NOT(B))
	xor $t3, $t0, $t1	# A XOR B
	or $t2, $t2, $t3	# C = NOT(A AND (NOT(B))) OR (A XOR B)
	
	la $a0, successMsg
	li $v0, 4
	syscall
	
	li $t1, 0x000000FF	# maschera per risultato in byte
	and $t2, $t2, $t1
	move $a0, $t0
	li $v0, 1
	syscall
	j end
	
error:	
	la $a0, errorMsg
	li $v0, 4
	syscall
	
end:	li $v0, 10
	syscall
	.end main