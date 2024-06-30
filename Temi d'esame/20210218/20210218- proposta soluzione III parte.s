#
# esame-18-02-2021
# 
# 
#
# =======================================================================================
   

		DIM = 11
		.data
vetRX:		.byte 0x84, 0xFA, 0x09, 0x54, 0x20, 0x42, 0x19, 0x20, 0x41, 0xB1, 0x03
vetTX:		.space DIM
 msg1 :   .asciiz " Prima : "
 msg2 :   .asciiz " Risultato : "
 spazio: .asciiz ","
		.text
		.globl main
		.ent main
    
main:	subu $sp, $sp, 4
    	sw $ra, ($sp)
      
      # Print PRIMA
      la $a0, msg1   
      li $v0, 4             
      syscall 
    
      la $t9, vetRX
      li $t8, 1
      
      loop21: nop
      lb  $a0, ($t9)  
      li  $v0, 1        # Print integer   
      syscall
      
      la $a0, spazio    
      li $v0, 4             
      syscall
      
      beq $t8,DIM, elab
      addi $t8, $t8,1
      addi $t9,$t9,1
      j loop21
      
      elab: nop   
		  la $a0, vetRX
		  la $a1, vetTX 
		  jal SpaceRemove
		 
      # Print RISULTATO
      la $a0, msg2    
      li $v0, 4             
      syscall 
    
      la $t9, vetTX
      li $t8, 1
      
      loop22: nop
      lb  $a0, ($t9)  
      li  $v0, 1        # Print integer   
      syscall
      
      la $a0, spazio    
      li $v0, 4             
      syscall
      
      beq $t8,DIM, fine
      addi $t8, $t8,1
      addi $t9,$t9,1
      j loop22
  
  fine: nop
	    lw $ra, ($sp)
	    addiu $sp, $sp, 4
	    jr $ra
	    .end main
  
     .ent SpaceRemove
     SpaceRemove : nop
     subu $sp, $sp, 4
	   sw $ra, ($sp) 
     move $s0, $a0       # vetRX
     move $s1, $a1       # vetTX                     
     li $t0, 0          # contatore elementi letti
   
     # 1^ Indirizzo
     subu $sp, $sp, 4   
     move $s2, $sp       # salvo SP    
     lb   $t1, 1($s0)
     andi $t1, $t1, 0x000000FF
     addi $t0, $t0, 1
	   sw $t1, ($sp)
     # 12 Indirizzo
     subu $sp, $sp, 4       
     lb   $t1, ($s0)
     andi $t1, $t1, 0x000000FF
     addi $t0, $t0, 1
	   sw $t1, ($sp)
     
     addiu $s0, $s0,1
     loop1: addiu $s0, $s0,1
            lb $t1, ($s0)
            beq $t1, 0x03, fine1
            beq $t1, 0x20, loop1
            subu $sp, $sp, 4       
            andi $t1, $t1, 0x000000FF
            addi $t0, $t0, 1
	          sb $t1, ($sp)
            j loop1   
                                    
            # creazione vettore TX
     fine1: #
            lb $t1, ($s2)      # leggo da stack
            sb  $t1, ($s1)     # memorizzo in vetTX
            sub $t0, $t0, 1    # decremento il contatore
            addiu $sp, $sp, 4  #dealloco $sp  
            beqz $t0, fine2
            subu $s2, $s2, 4  # incremento il puntatore
            addiu $s1, $s1,1   # incremento vetTX
	          j fine1     
          
     fine2: addiu $s1, $s1,1   # incremento vetTX
            li $t1, 0x03
            sb  $t1, ($s1)    # memorizzo in vetTX  EOT
             
            lw $ra, ($sp)
	          addiu $sp, $sp, 4
            jr $ra
    .end SpaceRemove    