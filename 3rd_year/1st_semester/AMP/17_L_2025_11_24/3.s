.data
numere:     .word 10 20 30 40 50
len:        .word 5
prop:       .asciiz "Media numerelor din vector: "

.text
.globl main

main:   
    li $t0, 0           # suma = 0
    lw $t1, len         # lungime
    la $t2, numere      # elem v
    li $t3, 0           # index

loop:
    bge $t3, $t1, calc_media # daca i
    lw $t3, 0($t2)      # incarcare
    add $t0, $t0, $t4   # adauga
    addi $t2, $t2, 4    # merge
    addi $t3, $t3, 1    # increme
    j loop

calc_media:
    move $t5, $t0
    div $t5, $t1
    mflo $t7

    la $a0, prop
    li $v0, 4
    syscall

    move $a0, $t7
    li $v0, 1
    syscall

    li $v0, 10
    syscall
