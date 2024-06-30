# COMPITO D'ESAME 2021-09-17    Proposta di soluzione
#



N = 3    #  RIGA
M = 4    #  COLONNA

.data
     matriceA: .word 0xAB317811, 0xCD514229, 0xEF832040, 0xA1346269
               .word 0xB2178309, 0xC3524578, 0x65702887, 0x59227465
               .word 0x14930352, 0x24157817, 0x39088169, 0x63245986
     matriceB: .word 0x39916800, 0x47900160, 0x62270208, 0x87178291
               .word 0xA7674368, 0xB2092278, 0xC3556874, 0xD6402373
               .word 0xE1216451, 0x24329020, 0x51090942, 0x11240007


    matriceC: .space N * M * 4
                
    
.text
.globl main
.ent main
main: subu $sp, $sp, 4
      sw $ra, ($sp)
      la $a0, matriceA
      la $a1, matriceB
      la $a2, matriceC
      li $a3, N      #RIGA 
      li $t0, M      #COLONNA     
      subu $sp, $sp, 4
      sw $t0, ($sp)
                 
      jal MediaMatrice 
            
      addiu $sp, $sp, 4
      lw $ra, ($sp)    

      addiu $sp, $sp, 4
      jr $ra
.end main


 

.ent MediaMatrice
MediaMatrice:
      lw $s4, ($sp)     #Recupero M  COLONNA
      move $s0, $a0     # Matrice A
      move $s1, $a1     # Matrice B
      move $s2, $a2     # Matrice C
      move $s3, $a3     # N RIGA

      # Calcolo DIM
      mul $t9, $s3, $s4      # in T9 le dimensioni della Matrice (NxM)
      
      # $T0 contatore scansione
      li $t0,0
      loop1:
      lw $t1, ($s0)
      lw $t2, ($s1)
        
      #Calcolo medie
      li $t7,  0x80000000
      xor $t5, $t1, $t2
      and $t5, $t5, $t7     # Se $t5=1 i segni erano opposti, se $t5=0 segni uguali
      beq $t5, $t7, opposti
      uguali :
              addu $t3, $t1, $t2
              srl $t3, $t3, 1                          
              bgt $t1, 0, uguali2            
              or $t3, $t3, $t7
              uguali2:
                sw $t3, ($s2)
                j cont
      opposti :
              add $t3, $t1, $t2
              sra $t3, $t3,1
              sw $t3, ($s2)                                                                             
              j cont
              
      cont: addi $t0, $t0, 1
            bge $t0, $t9, out
            addi $s0, $s0, 4
            addi $s1, $s1, 4
            addi $s2, $s2, 4
            j loop1
      out : nop
 
jr $ra
.end MediaMatrice








 