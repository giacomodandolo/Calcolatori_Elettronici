.data
cognome: .asciiz "ROSSI"
nome: .asciiz "GIOVANNI"
data: .asciiz "240357"
msg :   .asciiz " Risultato : " 
CF:    .space 12              # per la successiva stampa sfrutto il valore del primo byte oltre 12 che è = 0


.text
.globl main
.ent main
main: subu $sp, $sp, 4
sw $ra, ($sp)
la $a0, cognome
la $a1, nome
la $a2, data
la $a3, CF
jal CF12

# Print RISULTATO
la $a0, msg    
li $v0, 4             
syscall 
    
la $a0, CF    
li  $v0, 4        
syscall

lw $ra, ($sp)
addiu $sp, $sp, 4
jr $ra
.end main


.ent CF12
CF12:
subu $sp, $sp, 4
sw $ra, ($sp)

move $t0, $a0            # stringa input
move $t1, $a3            # stringa output
li $t3, 0 # flag
li $t4, 0 # contatore
ciclo: 
beq $t4, 3, controllo
lb $t2, ($t0)
beqz $t2, controllo
bltu $t2, 'B', next
bgtu $t2, 'Z', next
beq $t2, 'E', next
beq $t2, 'I', next
beq $t2, 'O', next
beq $t2, 'U', next
sb $t2, ($t1)                # Memorizzo il carattere
addiu $t1, $t1, 1
addiu $t4, $t4, 1
next: 
addiu $t0, $t0, 1
j ciclo

controllo: 
addiu $t3, $t3, 1
move $t0, $a1
li $t4, 0
bne $t3, 2, ciclo

controllo_data:
move $t0, $a2
lb $t3, ($t0)
sb $t3, ($t1)
lb $t3, 1($t0)
sb $t3, 1($t1)
addiu $t0, $t0, 2            #posiziono inizio MESE
addiu $t1, $t1, 2            #posiziono stringa out
#
lb $a0, ($t0)                #il contenuto originario di $a0 è salvato in $t0
sll $a0, $a0, 8
lb $t3, 1($t0) 
or $a0, $a0, $t3
jal MonthToChar
sb $v0, ($t1)
addiu $t0, $t0, 2            #posiziono inizio ANNO
addiu $t1, $t1, 1            #posiziono stringa out
lb $t3, ($t0)
sb $t3, ($t1)
lb $t3, 1($t0)
sb $t3, 1($t1)

move $t2, $a3                # in $t2 indirizzo inziale stringa output
li $t3, 0                    #accumulatore
ciclo_xor:
bge $t2, $t1, fine           # in $t1 indirizzo dell'ultimo carattere memorizzato (YY)
lb $t9, ($t2)
xor $t3, $t3, $t9
addiu $t2, $t2, 1
j ciclo_xor

fine:
addiu $t1, $t1, 2            #posiziono stringa per XOR
sb $t3, ($t1)

lw $ra, ($sp)
addiu $sp, $sp, 4
jr $ra

.end CF12


.ent MonthToChar
MonthToChar:
subu $sp, $sp, 4
sw $ra, ($sp)
subu $sp, $sp, 12
sw $t0, ($sp)
sw $t1, 4($sp)
sw $t2, 8($sp)

move $t0, $a0
srl $t0, $t0, 8
subu $t0, $t0, '0'
mul $t0, $t0, 10
move $t1, $a0
li $t2, 0xFF
and $t1, $t1, $t2
subu $t1, $t1, '0'
addu $t1, $t1, $t0
#in $t1 il numero
subu $t1, $t1, 1   # per partire con A
addu $v0, $t1, 'A'

lw $t2, 8($sp)
lw $t1, 4($sp)
lw $t0, ($sp)
addiu $sp, $sp, 12
lw $ra, ($sp)
addiu $sp, $sp, 4
jr $ra
.end MonthToChar