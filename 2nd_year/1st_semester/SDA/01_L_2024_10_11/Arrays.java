class Arrays {
    public static void main(String args[]) {
        int month_days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
        String months[]  = { "Ianuarie", "Februarie", "Martie"    , "Aprilie"  , "Mai"      , "Iunie",
                             "Iulie"   , "August"   , "Septembrie", "Octombrie", "Noiembrie", "Decembrie"};

        for(int i = 0; i < month_days.length; i++) {
           System.out.println(month_days[i] + " - " + months[i]);
        }

        System.out.println("\n---------------\n");

        System.out.println("Luniile cu 31 de zile:");
        for(int i = 0; i < month_days.length; i++) {
            if(month_days[i] == 31)
                System.out.println(months[i]);
        }

        System.out.println("\n---------------\n");

        System.out.println("Luniile sub 31 de zile:");
        for(int i = 0; i < month_days.length; i++) {
            if(month_days[i] < 31)
                System.out.println(months[i] + " - " + month_days[i]);
        }

    }
}
