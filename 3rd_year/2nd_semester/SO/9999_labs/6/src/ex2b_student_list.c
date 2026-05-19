#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct student {
    int id;
    char name[64];
    float grade;
    struct student *next;
};

static void add_student(struct student **head, int id, const char *name, float grade) {
    struct student *node = (struct student *)malloc(sizeof(struct student));
    if (node == NULL) {
        fprintf(stderr, "Out of memory\n");
        exit(1);
    }
    node->id = id;
    strncpy(node->name, name, sizeof(node->name) - 1);
    node->name[sizeof(node->name) - 1] = '\0';
    node->grade = grade;
    node->next = *head;
    *head = node;
}

static struct student *find_student(struct student *head, int id) {
    while (head != NULL) {
        if (head->id == id) {
            return head;
        }
        head = head->next;
    }
    return NULL;
}

static int update_student(struct student *head, int id, const char *new_name, float new_grade) {
    struct student *s = find_student(head, id);
    if (s == NULL) {
        return 0;
    }
    strncpy(s->name, new_name, sizeof(s->name) - 1);
    s->name[sizeof(s->name) - 1] = '\0';
    s->grade = new_grade;
    return 1;
}

static int delete_student(struct student **head, int id) {
    struct student *cur = *head;
    struct student *prev = NULL;
    while (cur != NULL) {
        if (cur->id == id) {
            break;
        }
        prev = cur;
        cur = cur->next;
    }
    if (cur == NULL) {
        return 0;
    }
    if (prev != NULL) {
        prev->next = cur->next;
    } else {
        *head = cur->next;
    }
    free(cur);
    return 1;
}

static void print_students(struct student *head) {
    while (head != NULL) {
        printf("id=%d, nume=%s, medie=%.2f\n", head->id, head->name, head->grade);
        head = head->next;
    }
    printf("\n");
}

static void free_students(struct student *head) {
    while (head != NULL) {
        struct student *next = head->next;
        free(head);
        head = next;
    }
}

int main(void) {
    struct student *head = NULL;

    add_student(&head, 101, "Ana", 9.25f);
    add_student(&head, 102, "Mihai", 8.70f);
    add_student(&head, 103, "Ioana", 9.80f);
    printf("Dupa adaugare:\n");
    print_students(head);

    update_student(head, 102, "Mihai Pop", 9.10f);
    printf("Dupa modificare id=102:\n");
    print_students(head);

    delete_student(&head, 101);
    printf("Dupa stergere id=101:\n");
    print_students(head);

    free_students(head);
    return 0;
}
