LEN = 4
		.data
testoInChiaro: .asciiz "calcolatorielettronici"
verme:	.ascii "mips"
testoCifrato:	.space 23


		.text
		.globl main
		.ent main
main:	subu $sp, $sp, 4
		sw $ra, 0($sp)
		la $a0, testoInChiaro
		la $a1, verme
		li $a2, LEN
		la $a3, testoCifrato
		jal cifrarioVigenere
		
		lw $ra, 0($sp)
		addiu $sp, $sp, 4
		jr $ra
		.end main

		.ent cifrarioVigenere
cifrarioVigenere: li $t0, 0			# indice del carattere corrente
		li $v0, 0		# numero di lettere cifrate

ciclo:	lb $t1, ($a0)
		beq $t1, 0, fineStringa

		addiu $v0, $v0, 1
		addu $t2, $a1, $t0		# indirizzo del carattere corrente nel verme
		lb $t3, ($t2)
		sub $t3, $t3, 'a'
		add $t1, $t1, $t3
		ble $t1, 'z', salvaCarattere
		sub $t1, $t1, 'z' + 1
		add $t1, $t1, 'a'
		
salvaCarattere: sb $t1, ($a3)
		addiu $a0, $a0, 1
		addiu $a3, $a3, 1
		addiu $t0, $t0, 1
		blt $t0, $a2, ciclo
		subu $t0, $t0, $a2
		b ciclo
		
fineStringa:	sb $t1, ($a3)
		jr $ra
		.end cifrarioVigenere
