# Traccia soluzione
#

  LEN = 4
  BASE_CAR = 97
  NUM_LETT = 25
  
		.data
testoInChiaro:	.asciiz "calcolatorielettronici"
verme:		    .ascii "mips"
msg :           .asciiz "Numero di lettere cifrate : " 
msg2 :          .asciiz "  -  Stringa Convertita : " 
testoCifrato:	.space 23

		.text
		.globl main
		.ent main
        
main:		
      subu $sp, $sp, 4
      sw $ra, ($sp)
      
      la $a0, testoInChiaro
	  la $a1, verme
	  li $a2, LEN
	  la $a3, testoCifrato
	  jal cifrarioVigenere	 
       	 
      move $s2,$v0          

      # Print RISULTATO
      la $a0, msg    
      li $v0, 4             
      syscall 
    
      move $a0, $s2  
      li  $v0, 1        
      syscall
      
      #Stampa stringa Convertita
      la $a0, msg2    
      li $v0, 4             
      syscall 
      
      la $a0, testoCifrato 
      li  $v0, 4        
      syscall

      
    loop_p_end:
      lw $ra, 0($sp)
      addiu $sp, $sp, 4
      jr $ra
.end main





#  INSERIRE IL CODICE DELLO STUDENTE    >>>>>>>>>>>>>>>>>>> ++

.ent cifrarioVigenere
cifrarioVigenere:
    subu $sp, $sp, 4
    sw $ra, ($sp)
    
    move $s0, $a0  #Stringa da codificare
    move $s1, $a1  # Verme
    move $s2, $a2  # Lunghezza Verme
    move $s3, $a3  # Stringa codificata
    
# Calcolo lunghezza stringa
    li $t0, 0       #contatore
    loop:
        lb $t1, ($s0)
        beqz $t1, end_loop
        addi $t0, $t0,1
        addi $s0, $s0,1
        j loop
    end_loop:
    sub $t0, $t0, 1
    move $t9, $t0       # $t9  Lunghezza stringa
              
    li $t0, 0       # contatore Verme
    li $t1, 0       # indice K
    li $t8, LEN-1   # Limite Verme
    li $t7,0        # GP
    move $s0, $a0   #Stringa da codificare
    loop1:
        lb $t3,($s1)
        sub $t3, $t3, BASE_CAR      # ordinale della lettera (i.e. m=12)
            
        li $t2,0       # contatore Stringa out
        li $t1,0       # azzero K
        loop2:  
            # eseguo calcolo (i+ k*N) dove i=$t0 e va in $t4
            mul $t4, $t1, LEN
            add $t4, $t4, $t0   # aggiungo posizione I
            addi $t1, $t1, 1    # incremento K
            li $t6, 0       #reset GP
            li $t7, 0       #reset GP
            add $t6, $s0, $t4       # in $t7 indirizzo elemento stringa da codificare 
            add $t7, $s3, $t4       # in $t7 indirizzo out
            bgt $t4, $t9, end_loop2         # test su offset $T4 non deve superare numero elementi stringa out
            # Leggo elemento stringa da codificare
            lb $t5,($t6)
            sub $t5, $t5, BASE_CAR      # ordinale della lettera (i.e. m=12)
            add $t5, $t5, $t3           # ordinale codificato
            ble $t5, NUM_LETT, cont
                # ricalcolo da A
                sub $t5, $t5, NUM_LETT+1
            cont:     
            add $t5, $t5, BASE_CAR           
            sb $t5, ($t7)       # aggiorno elemento stringa codificata
            addi $t2,$t2,1
            j loop2
        end_loop2:         
                      
        beq $t0, $t8, end_loop1
        add $t0, $t0,1
        add $s1, $s1,1  # passo all'elemento successivo del Verme
        j loop1
    end_loop1:  
        
fine:
      addi $t9, $t9, 1
      move $v0, $t9  
      lw $ra, 0($sp)
      addiu $sp, $sp, 4
      jr $ra
.end cifrarioVigenere



#  INSERIRE IL CODICE DELLO STUDENTE   ++ <<<<<<<<<<<<<<<<<<<< 