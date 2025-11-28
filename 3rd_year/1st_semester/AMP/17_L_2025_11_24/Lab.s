# afisare pe consola cate elemente sunt div cu 3 din vectorul dat

.data
vect: .word 1, 2, 3, 5, 9, 21, 27, 300, 104, 33
len:  .word 10      #.half 10
 prop: .asciiz "Numarul elementelor div cu 3 sunt:"

.text
.globl main

main:
la $a0, vect
lw $a1, len         #lh $a1, len
li $t0, 3           #incarcare divizor
li $t1, 0          #counter
li $t2, 0           #cate val vor fi divizibile cu 3

loop:
beq $t1, $a1, exit
lw $a3, 0($a0)
div $a3, $t0
mfhi $t3        #restul se pastreaza in $t3
bne $t3, $0, end    #daca rest=0 --> numar divizibil cu 3
addi $t2, 1

end:
addi $a0, 4     #adresa urmatorului elem din vector
addi $t1, 1
j loop

exit:
 la $a0, prop          #print_string = 4
 li $v0, 4
 syscall

add $a0, $0, $t2      #move $a0, $t2

li $v0, 1            #print_int = 1
syscall

li $v0, 10           #exit = 10
syscall


