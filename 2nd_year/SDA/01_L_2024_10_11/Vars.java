class Vars {
    public static void main(String args[]) {
        int x = 150;
        double y = 2.0;
        float z = 20f;
        byte b = 10;
        short c = 14;
        y = x;
        String str = "14";
        String str2 = "22.0";
        System.out.println(y);

        Integer idk = Integer.valueOf(str) + 5;
        Double idk2 = Double.parseDouble(str2) + 1;
        Double idk3 = y / 0.0;
        Boolean idk4 = idk3.isNaN();

        System.out.println(idk4);
    }
}
