public class Hamming {

    // This method accepts a character and an indication of parity (odd parity is
    // true; even parity is false). Your method must return a byte array of bits
    // that make up the Hamming code representation of the character
    public byte[] encode(char val, boolean parity) {
        byte[] hamCode = new byte[11];

        // Set pairty bits for even
        hamCode = setEventPairty(val, hamCode);
        if (parity){
            hamCode[0] = (byte) (hamCode[0] ^ 1);
            hamCode[1] = (byte) (hamCode[1] ^ 1);
            hamCode[3] = (byte) (hamCode[3] ^ 1);
            hamCode[7] = (byte) (hamCode[7] ^ 1);
        }

        //Input rest of number
        hamCode[2] = (byte) (val & 1); //3 Slot Ham 1 Slot Char
        hamCode[4] = (byte) (val >> 1 & 1); //5 Slot Ham 2 Slot Char
        hamCode[5] = (byte) (val >> 2 & 1); //6 Slot Ham 3 Slot Char
        hamCode[6] = (byte) (val >> 3 & 1); //7 Slot Ham 4 Slot Char
        hamCode[8] = (byte) (val >> 4 & 1); //9 Slot Ham 5 Slot Char
        hamCode[9] = (byte) (val >> 5 & 1); //10 Slot Ham 6 Slot Char
        hamCode[10] = (byte) (val >> 6 & 1); //11 Slot Ham 7 Slot Char
        

        // for (int i = 4; i < hamCode.length; i++) { // Loop through values of char to add to non pairty bit slots
        //     if (i != 7) {
        //         int bias = 3;
        //         if (i > 7)
        //             bias = 4;
        //         hamCode[i] = (byte) (val >> (i - bias) & 1);
        //     }
        // }

        printBits(hamCode);
        System.out.println();

        return hamCode;
    }

    public byte[] setEventPairty(char val, byte[] hamCode) {
        hamCode[0] = (byte) ((val >> 6 & 1) ^ (val >> 4 & 1) ^ (val >> 3 & 1) ^ (val >> 1 & 1) ^ (val & 1)); // 11, 9, 7, 5, 3
        hamCode[1] = (byte) ((val >> 7 & 1) ^ (val >> 5 & 1) ^ (val >> 2 & 1)); // 12, 10, 6
        hamCode[3] = (byte) ((val >> 7 & 1) ^ (val >> 5 & 1) ^ (val >> 2 & 1)); // 12, 7, 6, 5
        hamCode[7] = (byte) ((val >> 7 & 1) ^ (val >> 6 & 1) ^ (val >> 5 & 1) ^ (val >> 4 & 1)); // 12, 11, 10, 9

        return hamCode;
    }

    // This method takes a byte array of bits that represents Hamming code and an
    // indication of parity and decodes the representation to a character, which it
    // returns. This method should handle a 1-bit flip error by finding the error,
    // correcting it, and returning the original character.
    public char decode(byte[] array, boolean parity) {
        // Outer loop for parity bits inner loop

        return 'A';
    }

    public void printBits(byte[] bits) {
        for (int i = 0; i < bits.length; i++)
            System.out.print(bits[i]);
    }

    public static void main(String[] args) {
        final boolean ODDPARITY = true;
        final boolean EVENPARITY = false;

        Hamming ham = new Hamming();

        byte[] bits1 = ham.encode('d', ODDPARITY);
        byte[] bits2 = ham.encode('d', EVENPARITY);
        
        System.out.println("\n\n\n");
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