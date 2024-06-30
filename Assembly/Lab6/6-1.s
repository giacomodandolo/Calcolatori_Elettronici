# Scrivere due procedure:
# - stampaTriangolo: stampa un triangolo rettangolo isoscele di lato DIM;
# - stampaRettangolo: stampa un quadrato di lato DIM.

	.data
DIM	= 8
	.text
	.globl main
	.ent main

main:	
	jal stampaTriangolo
	li $a0, '\n'
	li $v0, 11
	syscall
	jal stampaRettangolo
	li $v0, 10
	syscall
	.end main
	
	
# Stampa un triangolo di asterischi.
stampaTriangolo:
	li $t0, 1
	li $v0, 11
printRowTri:
	li $a0, '*'
	li $t1, 0
printColTri:	
	syscall
	addi $t1, $t1, 1
	bne $t0, $t1, printColTri
	li $a0, '\n'
	syscall
	addi $t0, $t0, 1
	ble $t0, DIM, printRowTri
	jr $ra
.end stampaTriangolo

# Stampa un rettangolo di asterischi.
stampaRettangolo:
	li $v0, 11
	li $t0, 0
printRowRett:
	li $a0, '*'
	li $t1, 0
printColRett:	
	syscall
	addi $t1, $t1, 1
	bne $t1, DIM, printColRett
	li $a0, '\n'
	syscall
	addi $t0, $t0, 1
	blt $t0, DIM, printRowRett
	jr $ra
.end stampaRettangolo
