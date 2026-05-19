#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int n, m, i, j;
    int **a = NULL;
    printf("n=");
    scanf("%d", &n);
    printf("m=");
    scanf("%d", &m);

    a = (int **)calloc((size_t)n, sizeof(int *));
    if (a == NULL) {
        perror("Memorie insuficienta");
        return 1;
    }

    for (i = 0; i < n; i++) {
        a[i] = (int *)calloc((size_t)m, sizeof(int));
        if (a[i] == NULL) {
            perror("Memorie insuficienta");
            while (i > 0) {
                i--;
                free(a[i]);
            }
            free(a);
            return 1;
        }
    }

    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            printf("a[%d][%d]=", i, j);
            scanf("%d", &a[i][j]);
        }
    }

    printf("Matricea citita este:\n");
    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            printf("%d ", a[i][j]);
        }
        printf("\n");
    }

    for (i = 0; i < n; i++) {
        free(a[i]);
    }
    free(a);

    return 0;
}
