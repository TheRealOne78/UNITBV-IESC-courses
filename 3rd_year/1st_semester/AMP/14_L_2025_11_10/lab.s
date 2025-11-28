.data
prop:    .asciiz "Introdu un nr pentru a calcula factorialul lui 1: "
rasp:    .asciiz "\nRezultatul este: "
    
.text
.globl main

main:
    la $a0, prop
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    move $t0, $v0
    beq $t0, $0, display

    # 5! = 5*4*3*2*1
    li $t1, 1
    li $t2, 1




product:
    addi $t2, $t2, 1
    mul $t1, $t1, $t2
    blt $t2, $t0, product

    j result

display:
    la $a0, rasp
    li $v0, 4

    syscall

    li $a0, 1
    li $v0, 1
    syscall

    li $v0, 10
    syscall

result:
    la $a0, rasp
    li $v0, 4
    syscall

    move $a0, $t1     # add $a0, $t1
    li $v0, 1
    syscall

    li $v0, 10
    syscall
