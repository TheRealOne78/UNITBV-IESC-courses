package org.example;

public class Pair<T>
{
    public Pair(T firstElement, T secondElement) {
        first = firstElement;
        second = secondElement;
    }

    public void swap() {
        T tmp = first;
        first = second;
        second = tmp;
    }

    public T getFirst() { return first; }
    public T getSecond() { return second; }

    private T first;
    private T second;
}
