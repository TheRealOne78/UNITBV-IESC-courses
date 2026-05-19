#include <stdio.h>
#include <stdlib.h>

static void fractal(char **m, int x, int y, int size) {
    int i, j, step;
    if (size < 3) {
        return;
    }
    step = size / 3;
    for (i = x + step; i < x + 2 * step; i++) {
        for (j = y + step; j < y + 2 * step; j++) {
            m[i][j] = '.';
        }
    }
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            int nx, ny;
            if (i == 1 && j == 1) {
                continue;
            }
            nx = x + i * step;
            ny = y + j * step;
            fractal(m, nx, ny, step);
        }
    }
}

int main(void) {
    int n;
    char **m;

    printf("n (putere a lui 3) = ");
    if (scanf("%d", &n) != 1 || n <= 0) {
        fprintf(stderr, "n invalid\n");
        return 1;
    }

    m = (char **)calloc((size_t)n, sizeof(char *));
    if (m == NULL) {
        perror("Memorie insuficienta");
        return 1;
    }

    for (int i = 0; i < n; i++) {
        m[i] = (char *)calloc((size_t)n, sizeof(char));
        if (m[i] == NULL) {
            perror("Memorie insuficienta");
            while (i > 0) {
                i--;
                free(m[i]);
            }
            free(m);
            return 1;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            m[i][j] = '#';
        }
    }
    fractal(m, 0, 0, n);

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            putchar(m[i][j]);
        }
        putchar('\n');
    }

    for (int i = 0; i < n; i++) {
        free(m[i]);
    }
    free(m);
    return 0;
}
