#include <stdint.h>
#include <stdio.h>
 
union Float_t
{
    int32_t i;
    float f;
    struct
    {   
        uint32_t mantissa : 23;
        uint32_t exponent : 8;
        uint32_t sign : 1;
    } parts;
};

int main() {
    union Float_t fnum;

    // First, verify we have one word / 4 bytes in memory
    printf( "Memory size occupied by data : %d\n", sizeof(fnum));

    // Number should = 35.125
    fnum.i = 1108115456;
    printf( "Float version = %f\n", fnum.f);
    printf( "   Exponent = %x, mantissa = %x\n", fnum.parts.exponent, fnum.parts.mantissa);
    printf( "   OOPS: Exponent = %x, mantissa = %x\n", (fnum.parts.exponent-127), fnum.parts.mantissa);

    // Number should = 10.5625 (1010.1001 base 2)
    fnum.i = 0x41290000;
    printf( "Float version = %f\n", fnum.f);
    printf( "   Exponent = %x, mantissa = %x\n", fnum.parts.exponent, fnum.parts.mantissa);
    printf( "   OOPS: Exponent = %x, mantissa = %x\n", (fnum.parts.exponent-127), fnum.parts.mantissa);

    // Try with a float
    fnum.f = 23.75;
    printf( "Integer version = %d\n", fnum.i);
    printf( "   Exponent = %x, mantissa = %x\n", fnum.parts.exponent, fnum.parts.mantissa);
    printf( "   OOPS: Exponent = %x, mantissa = %x\n", (fnum.parts.exponent-127), fnum.parts.mantissa);

}
