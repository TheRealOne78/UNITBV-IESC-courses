package org.example;

public class PairUtil {
    public static <T extends Comparable<T>> Pair<T> minmax(T[] elements) {
        try {
            T min = elements[0], max = elements[0];

            for (T element : elements) {
                if (element.compareTo(min) < 0) {
                    min = element;
                }
                if (element.compareTo(max) > 0) {
                    max = element;
                }
            }

            return new Pair<>(min, max);

        } catch (Exception e) {
            System.out.println("E: " + e);
            throw e;
        }
    }
}
