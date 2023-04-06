/*************************************************************************
 * 
 * Week 1 Day 3 Exercise: Extract information from an IP address.
 * 
 * Mike Jipping, January 2021
 * 
 * Note we need "long" data types for parameters to methods.  We can't
 * use "int"s because they are not big enough for addresses as integers.
 */

public class Week01Day3 {

	// Here we extract the dotted notation by forming each set of 8 bits.
	// We shift the integer the appropriate distance and AND with 0xFF to 
	// extract the rightmost 8 bits.
	public void printDottedNotation(long address) {
		int octet1 = (int)(address >> 24 & 0xFF);
		int octet2 = (int)(address >> 16 & 0xFF);
		int octet3 = (int)(address >> 8 & 0xFF);
		int octet4 = (int)(address & 0xFF);
		
		System.out.println("Dotted notation: "+octet1+"."+octet2+"."+octet3+"."+octet4);
	}
	
	// Here we only have to do the AND and send it to printDottedNotation
	// for printing.
	public void printNetworkID(long address, long subnetmask) {
		long networkID = address & subnetmask;
		System.out.print("Network ID in ");
		printDottedNotation(networkID);
	}

	// Main code.
	// Test with 209.140.209.140.
	public static void main(String[] args) {
		Week01Day3 w01d3 = new Week01Day3();
		
		w01d3.printDottedNotation(3515666828L);
		w01d3.printNetworkID(3515666828L, 4294967040L);
	}

}
