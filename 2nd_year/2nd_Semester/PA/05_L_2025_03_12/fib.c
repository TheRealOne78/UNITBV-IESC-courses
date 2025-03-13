#include <stdio.h>

int fib_r(unsigned long n) {
    if (n < 2)
        return n;
    return fib_r(n - 1) + fib_r(n - 2);
}

int fib_i(unsigned long n) {
    unsigned long i = 0, j = 1, s = 1;
    for(unsigned long k = 1; k <= n; k++) {
        i = j;
        j = s;
        s = i + j;
    }

    return i;
}

int main() {
    fprintf(stdout, "Recursive: %d\n", fib_r(40));
    fprintf(stdout, "Itterative: %d\n", fib_r(40));

    printf("End!\n");
    return 0;
}
