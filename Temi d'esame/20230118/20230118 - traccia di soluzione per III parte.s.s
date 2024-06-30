# COMPITO D'ESAME 2023-01-18    Proposta di soluzione
#


DIM=7
.data
vettore:  .byte 11 5 1 4 6 2 12
msg1 :      .asciiz "Risultato : "

.text
.globl main
.ent main

main:	subu $sp, $sp, 4
	sw $ra, ($sp)

	la $a0, vettore
	li $a1, DIM
	jal EvenParity

    move $s2,$v0          
        
    # Print RISULTATO
    la $a0, msg1
    li $v0, 4             
    syscall   
      
    move $a0, $s2  
    li  $v0, 1       
    syscall 
		
	lw $ra, ($sp)
	addiu $sp, $sp, 4	
	jr $ra
.end main


 .ent EvenParity
EvenParity:
    subu $sp, $sp, 4
	sw $ra, ($sp)
 
    li $t6, 0           # contatore numero totale di elementi del vettore che hanno una parità Pari=1
    
 loop1:
    beqz $a1, fineloop1
    #
    lb $t1, ($a0)
    li $t2, 0       # contatore bit a 1
    li $t3, 1       # mask
    li $t5, 0       # contatore shift left
    loop3:
        beq $t5, 4, loop2
        #
        move $t9, $t1       # carico il byte da analizzare nel registro temporaneo
        and $t9, $t9, $t3   # in $t9 il risultato dell'and sul bit $t2-esimo
        beqz $t9, loop4
            addi $t2, $t2, 1  #incremento contatore bit a 1
        loop4:
            sll $t3, $t3, 1
            addi $t5, $t5, 1
            j loop3
    #
    loop2:
        # Un bit di parità Pari e' posto uguale a 1 se il numero di "1" in un certo insieme di bit e' dispari
        # in $t2 il numero degli "1"
        and $t2, $t2, 1
        beqz $t2, loop5           # numero "1" pari
        # numero "1" dispari
            ori $t1, $t1, 0x80        # set a 0 il bit + significativo
            sb $t1, ($a0)
            addi $t6, $t6, 1 
            j loop6
        loop5:
        # numero "1" pari
            and $t1, $t1, 0x7F       # set a 0 il bit + significativo
            sb $t1, ($a0)        
        loop6:
        add $a0, $a0, 1
        sub $a1, $a1, 1
    j loop1   
 
 fineloop1:
 
    move $v0, $t6
    
	lw $ra, ($sp)
	addiu $sp, $sp, 4 
    jr $ra
.end EvenParity










  
