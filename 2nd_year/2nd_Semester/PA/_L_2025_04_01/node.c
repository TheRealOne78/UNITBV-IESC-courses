#include <stdio.h>
#include <stdlib.h>

#include "node.h"

void search_tree_by_key(t_node *node, char* key) {

}

void node_insert_new(t_node *node, char* key, int newval) {
    t_node *newnode = (t_node*)malloc(sizeof(t_node));
    newnode->data   = newval;
    newnode->kids   = NULL;
    search_tree_by_key(node, key);
}
