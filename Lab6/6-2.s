# Scrivere due procedure con parametro:
# - stampaTriangolo: stampa un triangolo rettangolo isoscele di un dato lato;
# - stampaRettangolo: stampa un quadrato di un dato lato.

	.data
msgInsert:	.asciiz "Inserisci una dimensione: "
	.text
	.globl main
	.ent main

main:	
	la $a0, msgInsert
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	li $a0, '\n'
	li $v0, 11
	syscall
	
	move $a0, $s0
	jal stampaTriangolo
	
	li $a0, '\n'
	li $v0, 11
	syscall
	move $a0, $s0
	jal stampaRettangolo
	
	li $v0, 10
	syscall
	.end main
	
	
# Stampa un triangolo di $a0 asterischi.
stampaTriangolo:
	move $t2, $a0
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
	ble $t0, $t2, printRowTri
	jr $ra
.end stampaTriangolo

# Stampa un rettangolo di $a0 asterischi.
stampaRettangolo:
	move $t2, $a0
	li $t0, 1
	li $v0, 11
printRowRett:
	li $a0, '*'
	li $t1, 0
printColRett:	
	syscall
	addi $t1, $t1, 1
	bne $t1, $t2, printColRett
	li $a0, '\n'
	syscall
	addi $t0, $t0, 1
	ble $t0, $t2, printRowRett
	jr $ra
.end stampaRettangolo
