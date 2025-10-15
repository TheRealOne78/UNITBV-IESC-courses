.data
sir1:   .asciiz "Calculatoare"  # asciiz - directiva pentru string/char si contine indicator de NULL la final
sir2:   .asciiz "Electronica"   # asciiz - directiva pentru string/char si contine indicator de NULL la final
#m:  .double 10                  # .word - 10
#n:  .double 17                  # .word - 10

.text
.globl main

main:   
    #lh $t0, m
    #lh $t1, n
    #add $t2, $t0, $t1

    #move $a0, $t2               # add $a0, $t2, $0
    #li $v0, 1
    #syscall

    la $a0, sir1                # $a0 - registru destinat printarii
    li $v0, 4
    syscall                     # Printare pe consola

    la $a0, sir2                # $a0 - registru destinat printarii
    li $v0, 4
    syscall                     # Printare pe consola

exit:
    li $v0, 10
    syscall                     # exit

    # Apeluri de sistem -> syscall (cifre cu mesaj ascuns)
    # 1  = print_int
    # 4  = print_srt
    # 5  = read_int
    # 10 = exit
