#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_COLS 4096
#define MAX_ROWS 512

typedef struct Node {
    int value;
    int n;
    struct Node *left;
    struct Node *right;
} Node;

// Canvas for rendering
char canvas[MAX_ROWS][MAX_COLS];
int  canvas_rows = 0;
int  canvas_cols = 0;

Node *build_tree(int n) {
    Node *node = malloc(sizeof(Node));
    node->n = n;
    node->value = (n < 2) ? n : 0;
    node->left = NULL;
    node->right = NULL;
    if (n >= 2) {
        node->left = build_tree(n - 1);
        node->right = build_tree(n - 2);
        node->value = node->left->value + node->right->value;
    }
    return node;
}

void free_tree(Node *node) {
    if (!node) return;
    free_tree(node->left);
    free_tree(node->right);
    free(node);
}

// Returns the width (in columns) of a subtree
int tree_width(Node *node) {
    if (!node) return 0;
    if (!node->left && !node->right) {
        // leaf: width is number of digits
        int v = node->value;
        int w = 1;
        while (v >= 10) { v /= 10; w++; }
        return w;
    }
    int lw = tree_width(node->left);
    int rw = tree_width(node->right);
    // gap of at least 1 between children
    return lw + 1 + rw;
}

// Draw a string at (row, col) on canvas
void draw_str(int row, int col, const char *s) {
    int len = strlen(s);
    if (row >= MAX_ROWS) return;
    for (int i = 0; i < len; i++) {
        if (col + i >= MAX_COLS) break;
        canvas[row][col + i] = s[i];
        if (row + 1 > canvas_rows) canvas_rows = row + 1;
        if (col + i + 1 > canvas_cols) canvas_cols = col + i + 1;
    }
}

void draw_char(int row, int col, char c) {
    if (row >= MAX_ROWS || col >= MAX_COLS) return;
    canvas[row][col] = c;
    if (row + 1 > canvas_rows) canvas_rows = row + 1;
    if (col + 1 > canvas_cols) canvas_cols = col + 1;
}

// Lay out tree. col is the left edge of the space allocated for this subtree.
// Returns the column of the center of this node's label.
int layout(Node *node, int row, int col) {
    if (!node) return col;

    char label[32];
    snprintf(label, sizeof(label), "%d", node->value);
    int label_len = strlen(label);

    if (!node->left && !node->right) {
        draw_str(row, col, label);
        return col + (label_len - 1) / 2;
    }

    int lw = tree_width(node->left);
    int rw = tree_width(node->right);

    // left child center
    int lc = layout(node->left, row + 2, col);
    // right child center
    int rc = layout(node->right, row + 2, col + lw + 1);

    // place this node centered between its children's centers
    int center = (lc + rc) / 2;
    int label_start = center - (label_len - 1) / 2;
    draw_str(row, label_start, label);

    // draw branches row+1
    // left branch: from center-1 going left to lc
    draw_char(row + 1, center - 1, '/');
    for (int c = lc + 1; c < center - 1; c++)
        draw_char(row + 1, c, '_');

    // right branch: from center+label_len going right to rc
    draw_char(row + 1, center + 1, '\\');
    for (int c = center + 2; c < rc; c++)
        draw_char(row + 1, c, '_');

    return center;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <n>\n", argv[0]);
        return 1;
    }
    int n = atoi(argv[1]);
    if (n < 0) {
        printf("n must be >= 0\n");
        return 1;
    }

    Node *root = build_tree(n);

    // init canvas with spaces
    memset(canvas, ' ', sizeof(canvas));

    layout(root, 0, 0);

    // print canvas
    for (int r = 0; r < canvas_rows; r++) {
        // trim trailing spaces
        int end = canvas_cols;
        while (end > 0 && canvas[r][end - 1] == ' ') end--;
        canvas[r][end] = '\0';
        printf("%s\n", canvas[r]);
    }

    printf("\nfib(%d) = %d\n", n, root->value);

    free_tree(root);
    return 0;
}
