#ifndef STACK_H
#define STACK_H

template<class T> class Stack {
    public:
        Stack(int = 10);     //stiva are dimensiunea implicita 10
        ~Stack() {
            delete[] stackPtr;
        }                    //destructor
        bool push(const T&); //insereaza un element in stiva
        bool pop(T&);        //extrage un element din stiva
    private:
        int size;            //numarul de elemente din stiva
        int top;             //localizarea elementului din varful stivei
        T* stackPtr;         //pointer la stiva

        bool isEmpty() const {
            return top == -1;
        } //functii

        bool isFull() const {
            return top == size - 1;
        } //utilitare
};

template<class T> Stack<T>::Stack(int s) {
    size = s > 0 ? s : 10;
    top = -1;               //initial stiva este goala
    stackPtr = new T[size]; //alocarea spatiului pentru elemente
}

//Introduce un element in stiva
//Intoarce 1 daca s-a putut face inserarea si 0 in caz contrar
template<class T> bool Stack<T>::push(const T& pushValue) {
    if(!isFull())
    {
        stackPtr[++top] = pushValue; //plaseaza elementul in stiva
        return true; //inserare realizata cu succes
    }
    return false; //inserarea nu s-a putut realiza
}

//Extrage un element din stiva
template<class T> bool Stack<T>::pop(T& popValue) {
    if(!isEmpty())
    {
        popValue = stackPtr[top--]; //sterge elementul din stiva
        return true; //extragere realizata cu succes
    }
    return false; //extragerea nu s-a putut realiza
}

#endif
