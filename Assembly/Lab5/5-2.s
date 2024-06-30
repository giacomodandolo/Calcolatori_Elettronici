# Capire se la stringa introdotta è palindroma.

	.data
newLine:	.ascii "\n"
notPal:	.asciiz "La parola non è palindroma."
isPal:	.asciiz "La parola è palindroma."
	.text
	.globl main
	.ent main

main:	
	move $t0, $sp
	lb $t2, newLine
cycle:	
	li $v0, 12
	syscall
	beq $v0, $t2, endCycle
	sw $v0, ($sp)
	sub $sp, $sp, 4
	j cycle
	
endCycle:
	move $t1, $sp
	addi $t1, $t1, 4
checkPal:	
	lw $t3, ($t0)
	lw $t4, ($t1)
	bne $t3, $t4, endCheckFail
	sub $t0, $t0, 4
	addi $t1, $t1, 4
	ble $t1, $t0, checkPal
	j endCheckSucc
	
endCheckFail:
	li $v0, 4
	la $a0, notPal
	syscall
	j end
	
endCheckSucc:	
	li $v0, 4
	la $a0, isPal
	syscall

end:
	li $v0, 10
	syscall
	.end main