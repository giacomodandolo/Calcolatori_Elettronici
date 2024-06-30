# COMPITO D'ESAME 2023-06-23    Proposta di soluzione
#

NSTAZ=9
.data
biglietto:	.word 0, 170, 390, 580, 700, 960, 985, 1095, 1245
		.word 170, 0, 390, 580, 700, 960, 985, 1095, 1245
		.word 390, 390, 0, 420, 510, 700, 855, 960, 1075
		.word 580, 580, 420, 0, 300, 480, 640, 750, 900
		.word 700, 700, 510, 300, 0, 340, 495, 635, 755
		.word 960, 960, 700, 480, 340, 0, 300, 420, 580
		.word 985, 985, 855, 640, 495, 300, 0, 250, 360
		.word 1095, 1095, 960, 750, 635, 420, 250, 0, 250
		.word 1245, 1245, 1075, 900, 755, 580, 360, 250, 0
stazioni:	.ascii "Torino Porta Nuova;Torino Porta Susa;Chivasso;Santhia;Vercelli;Novara;Magenta;Rho-Fiera Milano;Milano Centrale;"			
partenza:	.asciiz "Chivasso"
arrivo:	    .asciiz "Magenta"
msg1 :      .asciiz "Risultato : "

.text
.globl main
.ent main

main:	subu $sp, $sp, 4
	    sw $ra, ($sp)

	    la $a0, stazioni
	    la $a1, biglietto
	    la $a2, partenza
	    la $a3, arrivo
       
	    subu $sp, $sp, 4
	    li $s0, NSTAZ
	    sw $s0, ($sp)
	    jal prezzoBiglietto           
	
        move $s2,$v0          
        
        # Print RISULTATO
        la $a0, msg1    
        li $v0, 4             
        syscall   
      
        move $a0, $s2  
        li  $v0, 1       
        syscall 
    
	    addiu $sp, $sp, 4
	    lw $ra, ($sp)
	    addiu $sp, $sp, 4	
	    jr $ra
        
.end main



 .ent prezzoBiglietto
prezzoBiglietto:
        #$a0, stazioni
	    #$a1, biglietto
	    #$a2, partenza
	    #$a3, arrivo
        subu $sp, $sp, 4
        sw $ra, ($sp)
        
        move $s0, $a0
        move $s1, $a1
        move $s2, $a2
        move $s3, $a3
        # Recupero NSTAZ
        lw $s4, 4($sp)
        
        move $a0, $s0
        move $a1, $s2
        move $a2, $s4   #numero stazioni
        jal cercaStazione
        # in $t8 indice Stazione partenza
        move $t8, $v0
        
        move $a0, $s0
        move $a1, $s3
        move $a2, $s4   #numero stazioni
        jal cercaStazione
        # in $t9 indice Stazione arrivo
        move $t9, $v0
           
        #Mi posiziono sulla riga della matrice Biglietto, all'inizio
        mul $t7, $s4, 4     #offset inizio riga
        mul $t7, $t7, $t8   #in $t8 stazione partenza
        move $a1, $s1       #riprisitino indirizzi Biglietti
        add $a1, $a1, $t7   # $a1 indirizzo prima casella riga stazione partenza
               
        #Mi posiziono sulla colonna corrispondente della matrice Biglietto
        mul $t7, $t9, 4
        add $a1, $a1, $t7
        lw $t9, ($a1)
        
        move $v0, $t9
        
        lw $ra, ($sp)
        addi $sp, $sp, 4
        jr $ra

.end prezzoBiglietto

 .ent cercaStazione
cercaStazione:
    #$a0 - vettore stazioni, $a1 - stringa stazione, $a2 - dim numero stazioni
    #$v0 - numero riga
    move $s5, $a0
    move $s6, $a1
    move $s7, $a2
    li $v0, 0       #contatore numero riga
    li $t2, 0
    li $t3, 0
    move $t0, $a0
    move $t1, $a1
    lp1:    lb $t2, ($t0)
            lb $t3, ($t1)
            beq $t2, ';', end1
            bne $t2, $t3, nuovoinizio
            addi $t0, $t0,1
            addi $t1, $t1,1
            j lp1
            
    nuovoinizio:
            addi $t0, $t0,1
            lb $t2, ($t0)
            bne $t2, ';', nuovoinizio
            addi $t0, $t0,1
            addi $v0, $v0, 1    # incremento contatore numero riga
            move $t1, $a1       # mi posiziono inizio stringa
            j lp1
          
    end1:   
    move $a0, $s5
    move $a1, $s6
    move $a2, $s7
    
    jr $ra

.end cercaStazione










  