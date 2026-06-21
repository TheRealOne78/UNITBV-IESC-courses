#ifndef __QUEUE_HPP__
#define __QUEUE_HPP__

template<class T> class Queue {
    public:
        Queue(int = 10);     //coada are dimensiunea implicita 10
        ~Queue() {
            delete[] queuePtr;
        }                    //destructor
        bool push(const T&); //insereaza un element in coada
        bool pop(T&);        //extrage un element din coada
    private:
        int size;            //numarul de elemente din coada
        int bottom;          //localizarea elementului din varful stivei
        T* queuePtr;         //pointer la coada

        bool isEmpty() const {
            return bottom == -1;
        } //functii

        bool isFull() const {
            return bottom == size - 1;
        } //utilitare
};

template<class T> Queue<T>::Queue(int s) {
    size = s > 0 ? s : 10;
    bottom = -1;            //initial coada este goala
    queuePtr = new T[size]; //alocarea spatiului pentru elemente
}

//Introduce un element in coada
//Intoarce 1 daca s-a putut face inserarea si 0 in caz contrar
template<class T> bool Queue<T>::push(const T& pushValue) {
    if(!isFull()) {
        queuePtr[++bottom] = pushValue; //plaseaza elementul in coada
        return true; //inserare realizata cu succes
    }
    return false; //inserarea nu s-a putut realiza
}

//Extrage un element din coada
template<class T> bool Queue<T>::pop(T& popValue) {
    if(!isEmpty()) {
        popValue = queuePtr[0]; // sterge primul element din coada

        /* Muta toate elementele */
        for(int i = 1; i < size; i++) {
            queuePtr[i-1] = queuePtr[i];
        }

        bottom--; // Actualizeaza index varf

        return true; //extragere realizata cu succes
    }
    return false; //extragerea nu s-a putut realiza
}


#endif // __QUEUE_HPP__
