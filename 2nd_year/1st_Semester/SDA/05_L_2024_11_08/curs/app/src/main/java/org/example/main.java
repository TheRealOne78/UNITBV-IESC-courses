package org.example;

public class main {

    public static <T extends Comparable<T>> int Search(T[] a, T key) {
        try {
            for (int i = 0; i < a.length; i++) {
                if (a[i].compareTo(key) == 0)
                    return i;
            }
        } catch (Exception e) {
            System.out.println("E: " + e);
        }

        return -1;
    }

    public static void main(String[] args) {
        Integer[] intArray = {25, 43, 11, 1888, 283};
        System.out.println("283: " + Search(intArray, 283));

        String[] stringArray = {"Hello", "World", "Foo", "Bar", "idk"};
        System.out.println("Foo: " + Search(stringArray, "Foo"));

        Pair<Integer> result = PairUtil.minmax(intArray);

        System.out.println("Min: " + result.getFirst());
        System.out.println("Max: " + result.getSecond());
    }
}
