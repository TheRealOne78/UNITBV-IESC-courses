#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX 10000000

void print_time() {
    system("date +%T");
}

int main() {
    printf("Fiu 2: PID=%d, PPID=%d, Ora: ", getpid(), getppid());
    print_time();

    for (int i = 0; i < 30; i++) {
        for (volatile int j = 0; j < MAX; j++);
        printf(".");
        fflush(stdout);
    }
    printf("\n");

    return 0;
}
