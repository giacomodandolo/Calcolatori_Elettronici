# COMPITO D'ESAME 2021-07-02


DIM = 8
.data
matrice: .byte 3, 1, 41, 5, 9, 26, 5, 35
.byte 89, 79, 32, 3, 8, 46, 26, 4
.byte 33, 8, 32, 79, 50, 28, 8, 4
.byte 19, 71, 69, 39, 9, 37, 5, 10
.byte 58, 20, 9, 74, 9, 44, 59, 2
.byte 30, 7, 8, 16, 40, 6, 28, 6
.byte 20, 8, 9, 98, 62, 80, 3, 48
.byte 25, 34, 21, 1, 70, 6, 7, 9

msg :   .asciiz " Risultato : " 
    
.text
.globl main
.ent main
main:
subu $sp, $sp, 4
sw $ra, ($sp)

la $a0, matrice
li $a1, 1
li $a2, DIM
jal maxInTriangolo
# lettura del risultato calcolato dalla procedura
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


maxInTriangolo:

move $s0, $a0     # Indirizzo matrice
move $s1, $a1     # Vertice
move $s2, $a2     # DIM

#Lato Verticale
ciclo1: li    $t2, 0     # contatore 
        li    $t9, 0     # MAX
        addu  $s0,$s0,$s1

loop1:  lb $t3, ($s0)
        ble $t3, $t9, cont1
        move $t9, $t3         # aggiorno il max
        cont1: nop
        bge $t2,$s1, ciclo2    
        addu $s0, $s0, $s2
        addi $t2,$t2,1
        j loop1  
         
#Lato Orizzontale        
ciclo2: subu $sp, $sp, 4      # salvo il max Orizzontale
        sw $t9, ($sp)
        
        move $s0, $a0 
        li    $t2, 0          # contatore 
        li    $t9, 0          # MAX
        mul   $t8, $s1, $s2   # calcolo offset
        addu  $s0,$s0,$t8
loop2:  lb $t3, ($s0)
        ble $t3, $t9, cont2
        move $t9, $t3         # aggiorno il max
        cont2: nop
        bge $t2,$s1, ciclo3    
        addi $s0, $s0, 1
        addi $t2,$t2,1
        j loop2
        
#Lato Ipotenusa
ciclo3: subu $sp, $sp, 4      # salvo il max Verticale
        sw $t9, ($sp)
        
        move  $s0, $a0 
        li    $t2, 0     # contatore 
        li    $t9, 0     # MAX
        addu  $s0,$s0,$s1

loop3:  lb    $t3, ($s0)
        ble   $t3, $t9, cont3
        move  $t9, $t3         # aggiorno il max
        cont3: nop
        bge   $t2,$s1, calcolo    
        addu  $s0, $s0, $s2
        sub   $s0,$s0,1
        addi  $t2,$t2,1
        j loop3  

        # Calcolo Max
calcolo:  lw $t8, ($sp)      # Max Verticale
          addiu $sp, $sp, 4
          bgt $t9, $t8, step1
          move $t9, $t8
step1:    lw $t8, ($sp)      # Max Orizzontale
          addiu $sp, $sp, 4
          bgt $t9, $t8, step2
          move $t9, $t8
          
step2:    move $v0, $t9  
          jr  $ra  
             
.end maxInTriangolo