#include <stdio.h>

void sel_min_sort(int row[], int size) {
    for(int i = 0; i < size; i++) {
        int minj = i, minx = row[i];

        for(int j = i + 1; j <= size; j++) {
            if(row[j] < minx) {
                minj = j;
                minx = row[j];
            }
        }
        row[minj] = row[i];
        row[i]    = minx;
    }
}

int main() {
    int row[] = {5, 2, 7, 3, 8, 9, 1};

    sel_min_sort(row, (sizeof(row) / sizeof(row[0])));

    for (int i = 0; i < (sizeof(row) / sizeof(row[0])); i++) {
        printf("%d\n", row[i]);
    }

    printf("End!\n");
    return 0;
}
