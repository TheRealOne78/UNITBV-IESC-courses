#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <time.h>

#define ITERATII 5
#define SLEEP_TIME 5

void print_time() {
    system("date +%T");
}

int main() {
    pid_t pid1, pid2;

    pid1 = fork();
    if (pid1 == 0) {
        // Child 1
        execl("./fiu1", "fiu1", NULL);
        perror("execl fiu1 failed");
        exit(1);
    }

    pid2 = fork();
    if (pid2 == 0) {
        // Child 2
        execl("./fiu2", "fiu2", NULL);
        perror("execl fiu2 failed");
        exit(1);
    }

    // Parent
    printf("Parinte: fiu1_pid=%d, fiu2_pid=%d\n", pid1, pid2);

    for (int i = 0; i < ITERATII; i++) {
        sleep(SLEEP_TIME);
        printf("Parinte (it %d): ", i + 1);
        print_time();
    }

    int status;
    pid_t wpid;
    while ((wpid = wait(&status)) > 0) {
        printf("Fiul %d este gata la ora: ", wpid);
        print_time();
    }

    return 0;
}
