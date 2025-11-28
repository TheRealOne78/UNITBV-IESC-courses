# nr M si N se vor printa
# toate numerele din interval [N:M]
# DIVIZIBILE CU 3
#
# var declarate in memorie
# daca N>M se vor printa numerele din [M:N]
# numerele afisate in consola

.data
    n:  .word 8
    m:  .word 22

.text
.globl main

main:
    lw $a1, n
    lw $a2, m
    li $a3, 3
    li $a0, 1
    
    slt $s1, $a1, $a2
    beq $s1, $a0, loop

    move $a0, $a1               # aux = n
    move $a1, $a2               # n   = m
    move $a2, $a0               # m   = aux 

loop:
    div $a1, $a3
    mfhi $s1
    beq $s1, $0, print

loop_incr:
    addi $a1, 1
    beq $a1, $a2, exit
    j loop

print:
    move $a0, $a1
    li $v0, 1
    syscall

    li $a0, 32
    li $v0, 11
    syscall

    j loop_incr

exit:
    li $v0, 10
    syscall
