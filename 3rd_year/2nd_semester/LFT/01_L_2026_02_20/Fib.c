#include <stdio.h>
#include <stdlib.h>

int fib_r(unsigned long n) {
    if (n < 2) {
        return n;
    }
    return fib_r(n - 1) + fib_r(n - 2);
}

int fib_i(unsigned long n) {
    unsigned long i = 0, j = 1, s = 1;
    for(unsigned long k = 2; k <= n; k++) {
        s = i + j;
        i = j;
        j = s;
    }
    return j;
}

int main(int argc, char* argv[]) {
    int n = atoi(argv[1]);

    printf("Recursive: ");
    for(int k = 1; k <= n; k++) {
        printf("%d ", fib_r(k));
    }
    printf("\n");

    printf("Iterative: ");
    for(int k = 1; k <= n; k++) {
        printf("%d ", fib_i(k));
    }

    return 0;
}
