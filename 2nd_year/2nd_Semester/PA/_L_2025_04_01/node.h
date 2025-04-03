#ifndef NODE_H_
#define NODE_H_

#include "./double_linked_list.h"

typedef struct Node {
    int data;
    struct Node* parent;
    t_llist* kids;
} t_node;

#endif // NODE_H_
