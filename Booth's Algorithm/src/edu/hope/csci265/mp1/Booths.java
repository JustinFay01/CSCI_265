package edu.hope.csci265.mp1;

import java.util.Scanner;

public class Booths extends Stallings {

    public Booths(int numberOfBits) {
        super(numberOfBits);
    }

    @Override
    public int multiply(byte multiplicand, byte multiplier) {
        // Start
        byte A = 0;
        byte M = (byte) (multiplicand & (twoToThe(n) - 1)); // to trim the number to n bits (Multiplicand)
        byte Q = (byte) (multiplier & (twoToThe(n) - 1)); // to trim the number to n bits (Multipler)
        byte count = n;// Number of Bits

        // Display the first line
        display(0, A, Q, M);
        System.out.println("    Initial values\n");
        int previousQ0 = 0; // Starting Q0
        // byte Q0 = (byte) (rightbit(Q));
        do {
            int Q0 = rightbit(Q); // new lsb
            if (Q0 == 0 && previousQ0 == 1) {
                // add M
                A = (byte) ((A + M) & (twoToThe(n) - 1));

                display(leftbit(A, n), A, Q, M);
                System.out.print("     Post Addition");
                System.out.println();
            } else if (Q0 == 1 && previousQ0 == 0) {
                // subtract m
                A = (byte) ((A - M) & (twoToThe(n) - 1));

                display(leftbit(A, n), A, Q, M);
                System.out.print("     Post Subtraction");
                System.out.println();
            }

            // right shift & count--
            previousQ0 = Q0; // Storing Last bit for next check
            Q = (byte) (((Q >> 1) | (rightbit(A) << (n - 1))) & (twoToThe(n) - 1)); // Shifting Multiplier and or'ing it
                                                                                    // with the lsb of A
            // Right Shifting A
            A = (byte) (((A >> 1) | (leftbit(A, (byte) n) << (n - 1))) & (twoToThe(n) - 1));

            display(leftbit(A, n), A, Q, M);
            System.out.print(" " + previousQ0 + "   Post Shift");
            System.out.println();
            System.out.println();
            count--;

        } while (count != 0);

        return ((A << n) | Q);

    }

    /**
     * 
     * @param result
     * @param n
     * @return
     *         Switch number from unsigned intger to signed int using twos
     *         complement
     *         First by complimenting the result then ANDing with the number of bits
     *         needed
     *         to select the first n bits
     */
    public static int twosComplement(int result, int n) {
        if (Math.pow(2, n) > Integer.MAX_VALUE)
            throw new IllegalArgumentException();
        int tmp = ((~(result)) & (int) Math.pow(2, 2 * n) - 1) + 1;
        return tmp;
    }

    /**
     * 
     * @param result
     * @param n
     * @return
     *         Used as a helper method to determine the end result is negative
     *         It does so by taking the result and the number of bits used in the
     *         multiplication process.
     *         The result is then shifted 2 * n (number of bits) - 1 (to preserve
     *         the sign bit) and then check if it is either 0 or 1
     */
    public static boolean checkSign(int result, int n) {
        if (Math.pow(2, n) > Integer.MAX_VALUE)
            throw new IllegalArgumentException();
        return (((result >> 2 * n - 1) & 1) == 1) ? true : false;
    }

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        System.out.println("Booths Algorithm Test\n");
        int n = 5;
        Booths b = new Booths(n);

        System.out.println("Enter two integer numbers");
        int n1 = scan.nextInt();
        int n2 = scan.nextInt();
        int result = b.multiply((byte) n1, (byte) n2);

        String out = "";
        if (checkSign(result, n)) {
            out = "-" + String.valueOf(twosComplement(result, n));
        } else
            out = String.valueOf(result);

        System.out.println("\n\nResult : " + n1 + " * " + n2 + " = " + out);
        scan.close();
    }
}
