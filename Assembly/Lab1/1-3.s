# Stampare a video la somma delle due variabili, utilizzando la syscall 1,
# e si verifichi che il risultato sia corretto.

	.data
op1:	.byte 150		# 1001 0110
op2:	.byte 100		# 0110 0100

	.text
	.globl main
	.ent main	
main:
	lbu $t1, op1		# dato che in CA2 l'1 iniziale indica
			# il segno, bisogna caricare il byte UNSIGNED
	lb $t2, op2
	add $a0, $t1, $t2	# senza UNSIGNED, la somma restituisce -6
			# con UNSIGNED, la somma restituisce 250
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	.end main