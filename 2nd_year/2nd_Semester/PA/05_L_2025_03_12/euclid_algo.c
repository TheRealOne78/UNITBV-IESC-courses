#include <stdio.h>

int euclid_algo(int m, int n) {
    while(n != 0) {
        int temp = n;
        n = m % n;
        m = temp;
    }

    return m;
}

int main() {
    fprintf(stdout, "%d\n", euclid_algo(102, 18));

    printf("End!\n");
    return 0;
}
