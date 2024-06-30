# Progamma chiamante per TEST COMPITO D'ESAME 2020-09-01
#


	.data
  msg :   .asciiz " Risultato : "
stringa1: .asciiz "Calcolatori Elettronici 2019/2020"  
stringa2: .asciiz "ALTO o basso?"

	.text
	.globl main
	.ent main
  
main:	subu $sp, $sp, 4
	sw $ra, ($sp)
  
	la $a0, stringa1
	la $a1, stringa2		
	jal cercaSequenza

  move $v1, $v0
  
  # Print RISULTATO
  la $a0, msg    
  li $v0, 4             
  syscall 
    
  move  $a0, $v1    
  li  $v0, 1        # Print integer   
  syscall
  
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	.end main



    #  INSERIRE PROCEDURA ESTRATTA AS IS DAL COMPITO
   
   .ent cercaSequenza
     cercaSequenza : nop
     subu $sp, $sp, 4
	   sw $ra, ($sp)
       move $s0, $a0       # str1
       move $s1, $a1       # str2
       li $t9,0            # reset contatore
      
      
       # ciclo su str2
       li $t0, 0      # puntatore str2 stringa di riferimento
       li $t1, 0      # puntatore str1
       
       lettura:
       # Lettura
       add $t2, $s1, $t0      # leggo carattere da str2
       lb $t3, ($t2)
       ori $t3, $t3, 0x20
       
       # Confronto esistenza carattere in str1
       # $a0 str1
       # $a1 puntatore 1^ carattere da controllare
       # $a2 carattere da cercare
       move $a0, $s0
       move $a1, $t1
       move $a2, $t3
       jal match
       nop
       beq $v0,99,fine2
       add  $t1, $v0,1     # aggiorno indice str1
       addi $t0, 1         # incremento indice str2
       add  $t9,$t9,1
       j lettura 
       
       fine2:
       move $v0, $t9
     	 lw $ra, ($sp)
	     addiu $sp, $sp, 4
    jr $ra
    .end cercaSequenza
    
    
    
      .ent match
       # Parametri-in : $a0=addr, $a1=puntatore, $a2=char
       # Parametri-out : 99=non trovato, posizione trovato
     match: nop
           subu $sp, $sp, 20
	         sw $ra, ($sp)
           sw $t0, 4($sp)
           sw $t1, 8($sp)
           sw $t2, 12($sp)
           sw $t3, 16($sp)
           li $v0, 99
           li $t0, 0
           
           loop1:
           add $t0, $a0, $a1    # puntatore posizione iniziale     
           lb $t2, ($t0)        # leggo il carattere
           beq $t2, 0, fine
           ori $t2, $t2, 0x20
           beq $t2, $a2, trovato
           no_trovato:
           add $a1, $a1, 1
           j loop1
           
           trovato:
           move $v0,  $a1
           
           fine:
           lw $t3, 16($sp)
           lw $t2, 12($sp)
           lw $t1, 8($sp)
           lw $t0, 4($sp)
     	     lw $ra, ($sp)
	         addiu $sp, $sp, 20
     
    jr $ra
    .end match