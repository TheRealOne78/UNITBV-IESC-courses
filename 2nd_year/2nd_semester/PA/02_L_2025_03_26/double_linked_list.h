#ifndef DOUBLE_LINKED_LIST_H_
#define DOUBLE_LINKED_LIST_H_

#include <stdint.h>

typedef struct llist {
    struct llist *p_next;
    int64_t       data;
    uint64_t      items;
} t_llist;

typedef struct dllist {
    struct dllist *p_next;
    struct dllist *p_prev;
    int64_t       data;
    uint64_t      items;
} t_dllist;

void dll_push(t_dllist *list, int64_t a) ;

void ll_push(t_llist *list, int64_t a) ;

int64_t dll_pop(t_dllist *list) ;

int64_t ll_pop(t_llist *list) ;

int64_t dll_del_n(t_dllist *list, uint64_t n) ;

int64_t ll_del_n(t_llist *list, uint64_t n) ;

void dll_add_n(t_dllist *list, uint64_t n, int64_t a) ;

void ll_add_n(t_llist *list, uint64_t n, int64_t a) ;

t_dllist* dll_get_last(t_dllist *list) ;

t_llist* ll_get_last(t_llist *list) ;


#endif // DOUBLE_LINKED_LIST_H_
