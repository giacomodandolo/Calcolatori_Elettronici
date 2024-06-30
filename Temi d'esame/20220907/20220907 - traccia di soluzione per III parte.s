# Traccia soluzione Esame 07/09/2022
#


.data
stringa1:	.asciiz "calcolatori elettronici"
stringa2:	.asciiz "raccolta"
msg1:		.asciiz "Risultato: "

.text
.globl main
.ent main

main:   subu $sp, $sp, 4
        sw $ra, ($sp)
    
        la $a0, stringa1
        la $a1, stringa2
        jal cercaSequenza
        move $s2, $v0
        
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
  	 

.ent cercaSequenza
cercaSequenza:      
li $t2, 0       # Puntatore esterno STRINGA2     
li $v0, 0       # max caratteri in comune
#Loop su STRINGA2 per ricavare le sottostringhe
loop1:
	add $t1, $a1, $t2	# In $t1 puntatore a SOTTOSTRINGA2
	lb $t4, ($t1)
	beq $t4, 0, ritorna 
	li $t5, 0		# num corrente di caratteri in comune 
	move $t0, $a0   # Address STRINGA1
	loop2:
		lb $t3, ($t0)
		beq $t3, 0, fine
		add $t0, $t0, 1
		bne $t4, $t3, loop2

		addi $t5, $t5, 1        # contatore uguaglianze
		add $t1, $t1, 1
		lb $t4, ($t1)           # test se SOTTOSTRINGA2 vuota
		beq $t4, 0, fine
		j loop2                                                           
	fine:
	# Aggiorno Max
	ble $t5, $v0, continua
	move $v0, $t5
	continua:
	addi $t2, $t2, 1	# sposto puntatore
	j loop1     
    
ritorna:
	jr $ra
.end cercaSequenza

