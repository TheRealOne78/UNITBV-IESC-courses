#include <stdio.h>
#include <stdlib.h>

#include "./double_linked_list.h"

void dll_push(t_dllist *list, int64_t a) {
    t_dllist *p_last = dll_get_last(list);
    t_dllist *p_new  = (t_dllist*) malloc(sizeof(t_dllist));
    p_new->data      = a;
    p_new->p_prev    = p_last;
    p_last->p_next   = p_new;
}

void ll_push(t_llist *list, int64_t a) {
    t_dllist *p_last = dll_get_last(list);
    t_dllist *p_new  = (t_dllist*) malloc(sizeof(t_dllist));
    p_new->data      = a;
    p_new->p_prev    = p_last;
    p_last->p_next   = p_new;
}

int64_t dll_pop(t_dllist *list) {
    t_dllist *p_last    = dll_get_last(list);
    t_dllist *p_newlast = p_last->p_prev;
    p_newlast->p_next   = NULL;

    int ret = p_last->data;
    free(p_last);

    return ret;
}

int64_t ll_pop(t_llist *list) {
    t_llist *p_last    = ll_get_last(list);
    t_llist *tmp_llist = list;

    while(tmp_llist->p_next != p_last) {
        tmp_llist = tmp_llist->p_next;
    }

    tmp_llist->p_next = NULL;

    int ret = p_last->data;
    free(p_last);

    return ret;

}

int64_t dll_del_n(t_dllist *list, uint64_t n) {
    t_dllist *tmp_p_list = list;

    for(uint64_t i = 0; i < n; i++) { //TODO: Test
        tmp_p_list = tmp_p_list->p_next;
    }

    (tmp_p_list->p_prev)->p_next = tmp_p_list->p_next;

    int64_t ret = tmp_p_list->data;
    free(tmp_p_list);

    return ret;
}

int64_t ll_del_n(t_llist *list, uint64_t n) {
    t_llist *tmp_p_list = list;

    for(uint64_t i = 0; i < (n - 1); i++) { //TODO: Test
        tmp_p_list = tmp_p_list->p_next;
    }

    t_llist *tmp_p_todel = tmp_p_list->p_next;
    tmp_p_list->p_next   = tmp_p_list->p_next->p_next;

    int64_t ret = tmp_p_todel->data;
    free(tmp_p_todel);

    return ret;
}

void dll_add_n(t_dllist *list, uint64_t n, int64_t a) {
}

void ll_add_n(t_llist *list, uint64_t n, int64_t a) {
    t_llist *tmp_p_list = list;

    for(uint64_t i = 0; i < (n - 1); i++) { //TODO: Test
        tmp_p_list = tmp_p_list->p_next;
    }

    t_llist *tmp_p_todel = tmp_p_list->p_next;
    tmp_p_list->p_next   = tmp_p_list->p_next->p_next;
}

t_dllist* dll_get_last(t_dllist *list) {
    t_dllist *tmp_dllist = list;

    while(tmp_dllist != NULL) {
        tmp_dllist = tmp_dllist->p_next;
    }

    return tmp_dllist;
}

t_llist* ll_get_last(t_llist *list) {
    t_llist *tmp_llist = list;

    while(tmp_llist != NULL) {
        tmp_llist = tmp_llist->p_next;
    }

    return tmp_llist;
}

int main() {
    t_llist  *list  = (t_llist *)malloc(sizeof(t_llist));
    t_dllist *dlist = (t_dllist *)malloc(sizeof(t_dllist));

    return 0;
}
