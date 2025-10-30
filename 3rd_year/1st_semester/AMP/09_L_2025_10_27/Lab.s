# Cate caractere sunt intr-un sir

.data
sir0:   .asciiz ">:3"
sir1:   .asciiz "Nr. de caractere din sir: "
sir2:   .asciiz "UWU"

.text
.globl main

main:   
    la $a0, sir0            # incarcare sir de caractere in registru
    li $t0, 0               # counter
    jal loop

    la $a0, sir1            # incarcare sir de caractere in registru
    li $t0, 0               # counter
    jal loop

    la $a0, sir2            # incarcare sir de caractere in registru
    li $t0, 0               # counter
    jal loop

    j exit

loop:   
    lb $a1, 0($a0)          # Se preiau 
    beq $a1, $0, output 
    addi $a0, 1             # addi $a0, $a0,
    addi $t0, 1             # addi $t0, $t0,    incr counter
    j loop


output:
    move $a0, $t0
    li $v0, 1
    syscall

    li $a0, 13
    li $v0, 11
    syscall
    jr $ra

exit:
    li $v0, 10
    syscall
