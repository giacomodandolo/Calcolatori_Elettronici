# Permettere di eseguire un'operazione tra le seguenti dati due operandi:
# 0. addizione
# 1. sottrazione
# 2. moltiplicazione
# 3. divisione intera

	.data
opa:	.word 2043
opb:	.word 5
res:	.word 0
tab:	.word somma, sottrazione, moltiplica, divisione
errorMsg:	.asciiz "Termino il programma."
	.text
	.globl main
	.ent main

main:	
	lw $t0, opa		# primo operando
	lw $t1, opb		# secondo operando
	
	li $v0, 5		# richiedi intero
	syscall
	
	blt $v0, 0, error	# se fuori dal range -> errore
	bgt $v0, 3, error
	
	sll $t2, $v0, 2	# trova label operazione
	lw $t2, tab($t2)	# carica label operazione
	jr $t2
	
somma:	
	add $t0, $t0, $t1
	j end
sottrazione:	
	sub $t0, $t0, $t1
	j end
moltiplica:	
	mul $t0, $t0, $t1
	j end
divisione:	
	div $t0, $t0, $t1
	j end
	
error:	
	la $a0, errorMsg
	li $v0, 4
	syscall
	j endError
	
end:	
	sw $t0, res
endError:
	li $v0, 10
	syscall
	.end main