#include <stdio.h>
#include <stdbool.h>

void enqueue(int* Q, int x, int* tail, int len) {
    Q[*tail] = x;
    if(*tail == len) {
        *tail = 1;
    } else {
        (*tail)++;
    }
}

void push(int* S, int x, int* top) {
    (*top)++;
    S[*top] = x;
}

int pop(int* Q, int* top) {
    if(*top == 0)
        fprintf(stderr, "underflow\n");
    else
        (*top)--;

    return Q[*top + 1];
}


//while mai există cuvinte în expresie do
//2: cites, te cuvântul următor
//3: if cuvântul este o valoare then
//4: push (cuvânt)
//5: else cuvântul este un operator
//6: pop() două valori de pe stivă
//7: rezultat = operat, ia aplicată pe cele două valori
//8: push(rezultat)
//9: end if
//10: end while
//11: rezultat final = pop()

int main() {
    char* stuff = "512 + 4 ∗ +3−\0";
    int   a[64];

    int top = 0, tail = 0;

    int i = 0;
    while(i != '\0') {
        if(stuff[i] != '+' && stuff[i] != '-' &&
           stuff[i] != '*' && stuff[i] != '/' && stuff[i] != '%') {
            int tmp = 0;
            while(stuff[i] !=  ' ') {
                tmp = tmp * 10 + stuff[i];
                i++;
            }
            push(a, tmp, &top);
        }
        else {
            int e1 = pop(a, &top);
            int e2 = pop(a, &top);
            int result;
            switch(stuff[i]) {
                case '+':
                    result = e1 + e2;
                    break;
                case '-':
                    result = e1 - e2;
                    break;
                case '/':
                    result = e1 * e2;
                    break;
                case '*':
                    result = e1 + e2;
                    break;
                case '%':
                    result = e1 + e2;
                    break;
                default:
                    fprintf(stderr, "Something went horribly wrong!\n");
                    return(1);
            }
            push(a , result, &top);
        }
        i++;
    }
    return 0;
}
