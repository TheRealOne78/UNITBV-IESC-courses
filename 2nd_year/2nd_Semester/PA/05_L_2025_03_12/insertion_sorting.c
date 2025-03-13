#include <stdio.h>

void insertion_sorting(int *row, int size) {
    for (int j = 1; j < size; j++) {
        int key = row[j];
        int i = j - 1;
        while (i >= 0 && row[i] > key) {
            row[i + 1] = row[i];
            i--;
        }
        row[i + 1] = key;
    }
}

int main() {
    int row[] = {5, 2, 7, 3, 8, 9, 1};

    insertion_sorting(row, (sizeof(row) / sizeof(row[0])));

    for (int i = 0; i < (sizeof(row) / sizeof(row[0])); i++) {
        printf("%d\n", row[i]);
    }

    printf("End!\n");
    return 0;
}
