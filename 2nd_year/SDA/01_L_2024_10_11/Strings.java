class Strings {
    public static void main(String[] args) {
        String arr[] = {"Now", "is", "the", "time", "for", "all", "good", "men",
                        "to", "come", "to", "the", "aid", "of", "their", "country"};

        String arr2[] = arr.clone();
        String tmp1;
        boolean isCompared = true;
        while(true) {
            isCompared = true;
            for(int i = 0; i < arr2.length - 1; i++) {
                if(arr2[i].compareTo(arr2[i+1]) > 0) {
                    tmp1 = arr2[i+1];
                    arr2[i+1] = arr2[i];
                    arr2[i] = tmp1;
                    isCompared = false;
                }
            }

            if(isCompared)
                break;
        }

        for(String str : arr2) {
            System.out.print(str + " ");
        }

        String str2 = "";

        for(String str : arr) {
            str2 += str + ",";
        }
        str2 = str2.substring(0, str2.length() - 1);

        System.out.println("\n" + str2);

        String[] arr3 = str2.split(",");

        for (String prarr3: arr3) {
            System.out.println(prarr3);
        }

        double d = 102939939.939E+20;
        boolean b = true;
        long l = 1232874;
        char[] arr4 = {'a', 'b', 'c', 'd', 'e', 'f', 'g' };

        String d_s = String.valueOf(d);
        String b_s = String.valueOf(b);
        String l_s = String.valueOf(l);
        String arr4_s = new String(arr4);

        System.out.println(d_s);
        System.out.println(b_s);
        System.out.println(l_s);
        System.out.println(arr4_s);

        Double d2 = Double.valueOf(d_s);
        Boolean b2 = Boolean.valueOf(b_s);
        Long l2 = Long.valueOf(l_s);
        char[] arr4_2 = arr4_s.toCharArray();

        System.out.println(d2);
        System.out.println(b2);
        System.out.println(l2);
        System.out.println(arr4_2);
    }
}
