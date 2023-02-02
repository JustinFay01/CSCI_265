package edu.hope.csci265.mp2;
import java.util.Arrays;


public class Hamming {

    // This method accepts a character and an indication of parity (odd parity is
    // true; even parity is false). Your method must return a byte array of bits
    // that make up the Hamming code representation of the character
    public byte[] encode(char val, boolean parity) {
        byte[] hamCode = new byte[11];

        // Original Numbers
        hamCode[2] = (byte) ((val >> 6) & 1);
        hamCode[4] = (byte) ((val >> 5) & 1);
        hamCode[5] = (byte) ((val >> 4) & 1);
        hamCode[6] = (byte) ((val >> 3) & 1);
        hamCode[8] = (byte) ((val >> 2) & 1);
        hamCode[9] = (byte) ((val >> 1) & 1);
        //hamCode[10] = (byte) (val & 1);

        // find parity
        int par = 0;
        for (int i = 0; i < hamCode.length; i++) {
            if (hamCode[i] == 1) {
                par ^= i + 1;
            }
        }

        // set parity
        hamCode[0] = (byte) (par & 1);
        hamCode[1] = (byte) (par >> 1 & 1);
        hamCode[3] = (byte) (par >> 2 & 1);
        hamCode[7] = (byte) (par >> 3 & 1);

        if (parity) {
            hamCode[0] = (byte) (hamCode[0] ^ 1);
            hamCode[1] = (byte) (hamCode[1] ^ 1);
            hamCode[3] = (byte) (hamCode[3] ^ 1);
            hamCode[7] = (byte) (hamCode[7] ^ 1);
        }

        return hamCode;
    }

    // This method takes a byte array of bits that represents Hamming code and an
    // indication of parity and decodes the representation to a character, which it
    // returns. This method should handle a 1-bit flip error by finding the error,
    // correcting it, and returning the original character.
    public char decode(byte[] array, boolean parity) {
        int result = 0;
        for(int i = 0; i < array.length; i++){
            if(array[i] == 1){
                result ^= i + 1;
            }
        }

        if(parity){
            String flip = Integer.toBinaryString(result);
            if(flip.length() < 4){
               flip = "0" + flip;
            }
            String flipped = "";
            for(int i = 0; i < flip.length(); i++){
                if(flip.charAt(i) == '0'){
                    flipped += 1;
                }
                else flipped += 0;
            }
            result = Integer.parseInt(flipped, 2);
        }
        if(result != 0) { //Error!
            array[result - 1] = (byte) (array[result - 1] ^ 1); //Fixed!
        } 
        //Decode
        String binary = "";
        for(int i = 2; i < array.length; i++){
           if((i + 1 & i) != 0){
                binary += array[i];
           }
        }

        return (char) Integer.parseInt(binary, 2);
    }

    public void printBits(byte[] bits) {
        for (int i = 0; i < bits.length; i++)
            System.out.print(bits[i] + " ");
    }

    public static void main(String[] args) {
        final boolean ODDPARITY = true;
        final boolean EVENPARITY = false;

        Hamming ham = new Hamming();

        // Test #1: 'A' should be 00100001001 in even parity
        byte[] A = ham.encode('A', EVENPARITY);
        System.out.print("'A' in even parity is ");
        ham.printBits(A);
        System.out.println();

        // Test #2: I should get the character back!
        char AA = ham.decode(A, EVENPARITY);
        System.out.println("We should get A back: " + AA);

        // Test #3: Flipping 1 bit should not matter
        A[5] = (byte) (A[5] ^ 1);
        AA = ham.decode(A, EVENPARITY);
        System.out.println("We should get A back: " + AA);
    }
}