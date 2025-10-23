.data
m:   .half 17 # half - 16b
n:   .word 36 # word - 32b

.text
.globl main

main:
    lh $t0, m
    lh $t1, n

    li $t0, 17
    li $t0, 36
