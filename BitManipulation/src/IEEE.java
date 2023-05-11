public class IEEE {

    public static void main(String[] args) {
        float var = 0xc24b0000;
        printIEEE(var);
        printIEEE(0x41dc0000);
       
    }

    public static void printIEEE(double num) {
        int sign = ((int) num >> 31) & 1;
        int exp = ((int) num >> 23) & 0xFF;
        int mantissa = ((int) num & 0x7FFFFF);

        System.out.println((Integer.toBinaryString(sign) + " | " + Integer.toBinaryString(exp) + " | " +  Integer.toBinaryString(mantissa)));

    }

}
