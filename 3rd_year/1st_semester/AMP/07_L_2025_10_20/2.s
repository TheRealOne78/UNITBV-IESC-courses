.data
m:  .half 10
n:  .half 20
prop:    .asciiz "Produsul numerelor este: "

.text
.globl main

main:
    lh $s0, m
    lh $s1, n
    mul $s2, $s0, $s1

    la $a0, prop    # a0: Registru destinat printarii
    li $v0, 4 # print string
    syscall 

    move $a0, $s2    # a0: Registru destinat printarii
    li $v0, 1 # print integer
    syscall 
