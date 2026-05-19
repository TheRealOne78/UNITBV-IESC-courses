#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void print_time() {
    system("date +%T");
}

int main() {
    printf("Fiul 1: PID=%d, PPID=%d, Ora: ", getpid(), getppid());
    print_time();
    
    sleep(30);
    
    return 0;
}
