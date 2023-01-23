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
        byte M = (byte) (multiplicand); // to trim the number to n bits (Multiplicand)
        byte Q = (byte) (multiplier); // to trim the number to n bits (Multipler)
        byte count = n;// Number of Bits

        // Display the first line
        display(0, A, Q, M);
        System.out.println("    Initial values\n");
        byte previousQ0 = 0; // Starting Q0
        byte Q0 = (byte) (rightbit(Q));
        do {

            if (Q0 == 0 && previousQ0 == 1) {
                // add M
                A = (byte) (A + M);

                display(leftbit(A, n), A, Q, M);
                System.out.print("     Post Addition");
                System.out.println();
            } else if (Q0 == 1 && previousQ0 == 0) {
                A = (byte) (A - M);

                display(leftbit(A, n), A, Q, M);
                System.out.print("     Post Subtraction");
                System.out.println();
            }

            
            // right shift & count--
            previousQ0 = (byte) (rightbit(Q)); // Storing Last bit for next check
            Q = (byte) ((Q >> 1) | (rightbit(A) << (n - 1))); // Shifting Multiplier and or'ing it with the lsb of A
            // Right Shifting A
            
            A = (byte) (A >> 1);

            Q0 = rightbit(Q); // new lsb

            display(leftbit(A, n), A, Q, previousQ0);
            System.out.print(" "+ previousQ0 + "   Post Shift");
            System.out.println();
            System.out.println();
            count--;

        } while (count != 0);

        return ((A << n) | Q);

    }

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        System.out.println("Booths Algorithm Test\n");
        Booths b = new Booths(4);

        System.out.println("Enter two integer numbers");
        int n1 = scan.nextInt();
        int n2 = scan.nextInt();
        int result = b.multiply((byte) n1, (byte) n2);
        System.out.println("\n\nResult : " + n1 + " * " + n2 + " = " + result);
        scan.close();
    }
}
