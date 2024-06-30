# Traccia soluzione
#

  DIM=5
.data
costante:    .word 12
intervalli:  .byte 0 2 4 7 10

.text
.globl main
.ent main

main:   subu $sp, $sp, 4
	    sw $ra, ($sp)
        
	    li $a0, 31
	    li $a1, 25
	    la $a2, intervalli
	    la $a3, costante
        
	    jal clima 
       		
	    lw $ra, ($sp)
	    addiu $sp, $sp, 4	
	    jr $ra
.end main
  	 

.ent clima
clima:
    subu $sp, $sp, 4
    sw $ra, ($sp)
    
    move $s0, $a0       # Temp. AMBIENTALE
    move $s1, $a1       # Temp. DESIDERATA
    move $s2, $a2       # Vettore Intervalli
    move $s3, $a3       # K
    
    li $t0, 0           # Contatore cicli

    #TEST se AMBIENTALE < DESIDERATA
    bgt $s0, $s1, calc
        li $v0, -1
        j finefine
    calc :
        sub $t2, $s0, $s1   # Delta temperatura tra AMBIENTALE e DESIDERATA
        
    loop1:
        lb $t1, ($a2)   # leggo elemento vettore
        bgt $t1, $t2, end_loop1
        addi $a2, $a2, 1
        addi $t0, $t0,1
        bge $t0, DIM, end_loop2
        j loop1
        
    end_loop1:       #Trovato valore
        move $v0, $t0
        j fine
    end_loop2:
        li $v0, DIM
    
    fine:  
    #CALCOLO
    lw $t9, ($a3)
    mul $v0, $v0, $t9
    
    finefine:  
    lw $ra, ($sp)
    addi $sp, $sp, 4
    jr $ra
.end clima

