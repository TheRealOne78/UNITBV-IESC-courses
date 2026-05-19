#include <stdio.h>
#include <stdlib.h>

struct linked_list {
    int item;
    struct linked_list *next;
};

static void insert(struct linked_list **head, int value) {
    struct linked_list *node = (struct linked_list *)malloc(sizeof(struct linked_list));
    if (node == NULL) {
        fprintf(stderr, "Out of memory\n");
        exit(1);
    }
    node->item = value;
    node->next = *head;
    *head = node;
}

static void delete_value(struct linked_list **head, int value) {
    struct linked_list *cur = *head;
    struct linked_list *prev = NULL;
    while (cur != NULL) {
        if (cur->item == value) {
            break;
        }
        prev = cur;
        cur = cur->next;
    }
    if (cur == NULL) {
        return;
    }
    if (prev != NULL) {
        prev->next = cur->next;
    } else {
        *head = cur->next;
    }
    free(cur);
}

static void print_list(struct linked_list *head) {
    struct linked_list *cur = head;
    while (cur != NULL) {
        printf("%d ", cur->item);
        cur = cur->next;
    }
    printf("\n");
}

static void free_list(struct linked_list *head) {
    while (head != NULL) {
        struct linked_list *next = head->next;
        free(head);
        head = next;
    }
}

int main(void) {
    struct linked_list *head = NULL;

    insert(&head, 1);
    insert(&head, 4);
    insert(&head, 2);

    print_list(head);
    delete_value(&head, 2);
    print_list(head);
    delete_value(&head, 1);
    print_list(head);
    delete_value(&head, 4);
    print_list(head);

    free_list(head);
    return 0;
}
