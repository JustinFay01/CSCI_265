public class bitManipulation {
    public static void main(String[] args) throws Exception {
       System.out.println("Dotted Notation: " + printDottedNotation(3515666828L)); 
        System.out.println("Network ID in Dotted Notation: " + printNetWorkID(3515666828L, 4294967040L));
    }

    // This method will take an integer and print the dotted notation from it.
    public static String printDottedNotation(long address) {
        return ((address >> 24) & 0xFF) + "." 
		+ ((address >> 16) & 0xFF) + "." 
		+ ((address >> 8) & 0xFF) + "." 
		+ (address & 0xFF);
    }

    /*
     * This method will take an address and subnet mask as integers and will print
     * the network
     * ID from the address.
     */
    public static String printNetWorkID(long address, long subnetmask) {
        long decimal = (address & subnetmask);
        return printDottedNotation(decimal);
        
    }
}
