# con syscall

	.data
	
	.text
	.globl main
	.ent main

main:	
	
	li $v0, 10
	syscall
	.end main
	
	
	
# con $ra

	.data
	
	.text
	.globl main
	.ent main

main:	
	subu $sp, 4
	sw $ra, ($sp)
	
	
	lw $ra, ($sp)
	addiu $sp, 4
	jr $ra
	.end main