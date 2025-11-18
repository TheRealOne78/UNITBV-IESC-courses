.data
    # definim in memorie vector
vect0:    .half 4, -23, 78, 45, 54, -7
len0:     .half 6

vect1:    .half 45, 54, -9
len1:     .half 3

vect2:    .half 45, 54
len2:     .half 2
    
.text
.globl main

main:
    la $a0, vect0
    li $t0, 0            # counter
    lh $t1, len0
    li $t2, -32768       # element etalon
    jal maxim

    la $a0, vect1
    li $t0, 0            # counter
    lh $t1, len1
    li $t2, -32768       # element etalon
    jal maxim

    la $a0, vect2
    li $t0, 0            # counter
    lh $t1, len2
    li $t2, -32768       # element etalon
    jal maxim

maxim:
    subu $sp, $sp, 32
    sw $ra, 20($sp)
    sw $t2, 16($sp)
    
    beq $t0, $t1, afisare_max
    lh $s3, 0($a0)
    addi $a0, $a0, 2
    addi $t0, $t0, 1
    slt $s0, $t2, $t3
    bne $s1, 1, maxim
    add $t2, $0, $s3
    j maxim

afisare_maxim:
    jal afisare

    lw $ra, 20($sp)
    lw $t2, 16($sp)
    addu $sp, $sp, 32
    
    jr $ra

afisare:    
    add $a0, $0, $t2
    li $v0, 1
    syscall

    la $a0, 13
    li $v0, 11
    syscall

    
    move $a0, $t2
    li $v0, 1
    syscall

exit:   
    li $v0, 10
    syscall

#   slt $s0, $t2, $t3 => daca t2<t3, $s0 = 1
