package edu.hope.csci265.mp1;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class BoothTest {
	
	Booths booth0;
	Booths booth1; 
	Booths booth2;

	@Before
	public void setUp() throws Exception {
		booth0 = new Booths(3);  // integers from -4 to 3
		booth1 = new Booths(5);  // integers from -16 to 15 
		booth2 = new Booths(7);  // integers from -64 to 63
	}

	@Test
	public void testInstantiation() {
		assertNotNull(booth0);
		assertNotNull(booth1);
		assertNotNull(booth2);
	}
	
	@Test
	public void testZero() {
		int result0 = booth0.multiply((byte)0, (byte)0);
		assert(result0 == 0);
		int result1 = booth1.multiply((byte)10, (byte)0);
		assert(result1 == 0);
		int result2 = booth2.multiply((byte)0, (byte)33);
		assert(result2 == 0);
	}
	
	@Test
	public void testOne() {		
		int result0 = booth0.multiply((byte)1, (byte)1);
		assert(result0 == 1);
		int result1 = booth1.multiply((byte)10, (byte)1);
		assert(result1 == 10);
		int result2 = booth2.multiply((byte)1, (byte)33);
		assert(result2 == 33);
	}

	@Test
	public void testPositive() {		
		int result0 = booth0.multiply((byte)2, (byte)2);
		assert(result0 == 4);
		int result1 = booth1.multiply((byte)10, (byte)4);
		assert(result1 == 40);
		int result2 = booth2.multiply((byte)10, (byte)23);
		assert(result2 == 230);
	}

	@Test
	public void testNegative() {		
		int result0 = booth0.multiply((byte)-2, (byte)2);
		assert(result0 == 60);
		int result1 = booth1.multiply((byte)8, (byte)-7);
		assert(result1 == 968);
		int result2 = booth2.multiply((byte)-50, (byte)3);
		assert(result2 == 16234);
	}

	@Test
	public void testEdges() {		
		int result0 = booth0.multiply((byte)3, (byte)-4);  
		assert(result0 == 52);
		int result1 = booth1.multiply((byte)15, (byte)-16);
		assert(result1 == 784);
		int result2 = booth2.multiply((byte)63, (byte)-64);
		assert(result2 == 12352);
	}

}