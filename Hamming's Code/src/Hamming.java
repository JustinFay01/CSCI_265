public class Hamming {

    // This method accepts a character and an indication of parity (odd parity is
    // true; even parity is false). Your method must return a byte array of bits
    // that make up the Hamming code representation of the character
    public byte[] encode(char val, boolean parity) {
        byte[] hamCode = new byte[11];
        //set 0 parity bit
        if(parity) hamCode[0] = 0;
        else hamCode[0] = 1;

        //Set pairty bits
        hamCode[1] = 
        hamCode[2]
        hamCode[4]
        hamCode[8]
    

        printBits(hamCode);

        return hamCode;
    }

    // This method takes a byte array of bits that represents Hamming code and an
    // indication of parity and decodes the representation to a character, which it
    // returns. This method should handle a 1-bit flip error by finding the error,
    // correcting it, and returning the original character.
    public char decode(byte[] array, boolean parity) {
        //Outer loop for parity bits inner loop 




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