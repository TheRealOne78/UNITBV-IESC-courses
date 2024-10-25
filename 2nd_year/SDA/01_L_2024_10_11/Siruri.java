class Siruri {
    public static void main(String[] args) {
        int a[] = {12, 54, 2, 78, 36, 22, 92};
        int b[] = {33, 6, 19, 86, 54, 44, 20, 78};
        int cnt = 0;

        for(int i : a) {
            for (int j : b) {
                if (i == j)
                    cnt++;
            }
        }

        System.out.println("Nr. de elemente comune: " + cnt);

        int c[] = {23, 56, 79, 61, 34, 61, 79, 56, 23};
        int d[] = {21, 44, 37, 90, 21, 44, 37};

        boolean palindrome = true;
        for(int i = c.length - 1, j = 0; i > 0 && j < c.length; i--, j++) {
            if(c[i] != c[j]) {
                palindrome = false;
                break;
            }
        }
        System.out.println("Palindrome - " + palindrome);

        boolean palindrome2 = true;
        for(int i = d.length - 1, j = 0; i > 0 && j < d.length; i--, j++) {
            if(d[i] != d[j]) {
                palindrome = false;
                break;
            }
        }
        System.out.println("Palindrome - " + palindrome);

        int M[][] = {{1, 1, 2}, {5, 0, 0}, {2, 3, 3}};
        int m[] = new int[M.length];

        for(int i = 0; i < M.length; i++) {
            for(int j = 0; j < M[i].length; j++) {
               m[j] += M[i][j];
            }
        }

        for(int i = 0; i < m.length; i++) {
            System.out.print(m[i] + " ");
        }
    }
}
