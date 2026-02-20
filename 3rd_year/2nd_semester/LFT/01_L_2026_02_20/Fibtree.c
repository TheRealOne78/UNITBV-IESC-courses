#include <stdio.h>
#include <stdlib.h>

int fib_tree(int n, int depth) {
    for(int i = 0; i < depth; i++) printf("  ");
    printf("fib(%d)\n", n);

    if (n < 2) return n;

    int left = fib_tree(n - 1, depth + 1);
    int right = fib_tree(n - 2, depth + 1);

    return left + right;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Usage: %s <n>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);
    printf("Fibonacci recursion tree for n=%d:\n", n);
    int result = fib_tree(n, 0);
    printf("Result: %d\n", result);

    return 0;
}
