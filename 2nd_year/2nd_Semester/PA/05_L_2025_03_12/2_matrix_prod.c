#include <stdio.h>

void* prod_2matrix(int *matrix1,
                   int size1,
                   int *matrix2,
                   int size2) {
   for(int i)
}

int main() {
    int a[] = {1, 2, 4, 6, 8, 9};
    int b[] = {1, 5, 6, 8, 9};

    int *c = (int*) prod_2matrix(a, (sizeof(a) / sizeof(a[0])),
                                 b, (sizeof(b) / sizeof(b[0])));

    int i = 0;
    while(c[i] != '\0') {
        printf("%d\n", c[i]);
    }

    return 0;
}
