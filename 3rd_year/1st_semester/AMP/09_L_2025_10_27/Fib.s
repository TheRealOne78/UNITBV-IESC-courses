# 0 1 1 2 3 5 8 13 21
    
.data
numar:  .word 12

.text
.globl main

main:
    lw $t0, numar
    li $t1, 1   # counter
    li $t2, 1   # elem2 din sir
    li $t3, 0   # elem 1 din sir

loop:   
    addi $t1, $t1, 1   # incrementare counter
    add $t4, $t2, $t3
    jal print

    move $t3, $t2
    move $t2, $t4
    beq $t0, $t1, exit

    j loop

print:
    add $a0, $0, $t4    # move $a0, $t4

    li $v0, 1           # 1 = print_at
    syscall

    li $a0, 32
    li $v0, 11
    syscall

    jr $ra

exit:
    li $v0, 10
    syscall
