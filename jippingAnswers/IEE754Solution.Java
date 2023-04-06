/*************************************************************************
 * 
 * Week 2 Day 3 Exercise: Convert a bit string representing IEEE 754 format
 * to a floating point number.
 * 
 * Mike Jipping, January 2021
 */

import java.util.Scanner;

public class Week02Day3 {
    
    // Method takes a string of 0's and 1's that represents IEEE 754 format
    // and rips it apart into the pieces, and computes and returns the floating
    // point number it represents.
    public float decode(String bitstring) {

        // The sign bit is easy.
        String s = bitstring.substring(0,1);
        int sign = (s.equals("0"))?1:-1;

        // The exponent is from position 1 through 8.  Then we compute
        // what the bits represent in binary, then we subtract 127 for
        // bias notation.
        String e = bitstring.substring(1,9);
        int exponent = 0;
        for (int i=0; i<8; i++) {
            int bit = (e.substring(i, i+1).equals("0"))?0:1;
            exponent = exponent * 2 + bit;
        }
        exponent = exponent - 127;  // for bias notation

        // And now the mantissa.  Note that this is supposed to be what
        // is right of the binary point, so we compute the number from 
        // right to left, dividing as we work through the bits.
        float m = 0;
        String mant = bitstring.substring(9, 32);
        for (int i=22; i>=0; i--) {
            int bit = (mant.substring(i, i+1).equals("0"))?0:1;
            m = m/2 + bit;
        }
        float mantissa = 1 + m / 2;

        // Finally, compute the result and return it.
        float f = sign * (float)(mantissa * Math.pow(2, exponent));
        return f;
    }

    // Main method code.  Read in a float, convert it to an IEEE 754 string,
    // and call the conversion method.
    public static void main(String[] args) {
        Week02Day3 w02d3 = new Week02Day3();

        Scanner scan = new Scanner(System.in); 
        System.out.print("Please enter a floating point number: ");
        float f = scan.nextFloat();

        int intBits = Float.floatToIntBits(f); 
        String bString = Integer.toBinaryString(intBits);
        if (f >= 0) bString = "0" + bString;

        // These two lines should print the same floating point numbers.
        System.out.println("The bitstring representing "+f+" is "+bString);
        System.out.println(bString + " converted = " + w02d3.decode(bString));
    }
    
}