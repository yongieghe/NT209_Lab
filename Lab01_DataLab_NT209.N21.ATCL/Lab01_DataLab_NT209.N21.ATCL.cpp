#include <stdio.h>
#include<iostream>
int bitOr(int x, int y)
{
    //Su dung De Morgan
    return ~(~x&~y);
}

void PrintBits(unsigned int x) 
{
    int i;
    for (i = 8 * sizeof(x) - 1; i >= 0; i--) {
        (x & (1 << i)) ? putchar('1') : putchar('0');
    }
    printf("\n");
}

int negative(int x)
{
    //su dung bu 2
    return (~x+1);
}

int flipByte(int x, int n)
{
    //n<<3: lay byte thu n
	// 0xff << (n<<3): Mask để XOR => 0 -> 1, 1-> 0
    return x ^ (0xff << (n<<3));
}

int setBit(int x, int n)
{
    // or voi 1 bit thu n
	return (x | (1 << n));
}


unsigned int mulpw2(unsigned int x, int n)
{ 
	PrintBits(n >> 31);
	PrintBits(~(n >> 31));
	//lay bit dau tien cua n => n am hay duong
	//neu n am => bit dau bang 1 => lam (x >> (~n + 1)))
	//nguoc lai n duong => bit dau bang 0 => lat lai bang 1 => lam x << n 
    return ((n >> 31) & (x >> (~n + 1))) | (~(n >> 31) & (x << n));
}



int isEven(int x) {
	//lay bit cuoi cung 
    return !(x << 31);
}
int isGE(int x,int y) {
	//(x - y) lay bit dau tien
	//neu duong => X lon hon Y => bit dau = 0 =>!0 = 1
	//neu am => X be hon Y => bit dau = 1 => !1    = 0 
	//Neu bang 0 => X bang Y => bit dau = 0 => !0  = 1  
    return !((x +(~y+1)>>31));
}

int isPositive(int x) {
	//x>>31 lay bit dau tien cua X
	//Neu x duong => bit dau bang 0 => !(x>>31) == 1 ^ !x = 1^0	 = 1;
	//Neu x am  => bit dau bang 1 => !(x>>31) == 0 ^ !x = 0^0	 = 0;
	//Neu x = 0 => bit dau bang 0 => !(x>>31) == 1 ^!x = 1^1	 = 0
    return (!(x>>31) ^ !x);
}

int isGE2n(int x, int n) 
{ 
	//x - 2^n
	//neu duong => X lon hon 2^n => bit dau = 0 =>!0 = 1
	//neu am => X be hon 2^n => bit dau = 1 => !1    = 0 
	//Neu bang 0 => X bang 2^n => bit dau = 0 => !0  = 1 
    return !((x + (~(1<<n)+1) >> 31));
}

int main()
{
	int score = 0;
	printf("Your evaluation result:");
	printf("\n1.1 bitOr");
	if (bitOr(3, -9) == (3 | -9))
	{
		printf("\tPass.");
		score += 1;
	}
	else
		printf("\tFailed.");

	printf("\n1.2 negative");
	if (negative(0) == 0 && negative(9) == -9 && negative(-5) == 5)
	{
		printf("\tPass.");
		score += 1;
	}
	else
		printf("\tFailed.");

	//1.3
	printf("\n1.3 setBit");
	if (setBit(6, 2) == 6 && setBit(5, 0) == 5 && setBit(32, 3) == 40)
	{
		printf("\tPass.");
		score += 2;
	}
	else
		printf("\tFailed.");

	printf("\n1.4 flipByte");
	if (flipByte(10, 0) == 245 && flipByte(0, 1) == 65280 && flipByte(0x5501, 1) == 0xaa01)
	{
		printf("\tPass.");
		score += 3;
	}
	else
		printf("\tFailed.");
	//1.5
	printf("\n1.5 mulpw2");
	if (mulpw2(10, -1) == 5 && mulpw2(15, -2) == 3 && mulpw2(32, -4) == 2)
	{
		if (mulpw2(10, 1) == 20 && mulpw2(50, 2) == 200)
		{
			printf("\tAdvanced Pass.");
			score += 4;
		}
		else
		{
			printf("\tPass.");
			score += 3;
		}
	}
	else
		printf("\tFailed.");

	printf("\n2.1 isEven");
	if (isEven(4) == 1 && isEven(13) == 0 && isEven(0) == 1)
	{
		printf("\tPass.");
		score += 2;
	}
	else
		printf("\tFailed.");

	printf("\n2.2 isGE");
	if (isGE(16, 4) == 1 && isGE(-5, -3) == 0 && isGE(5, 5) == 1)
	{
		printf("\tPass.");
		score += 2;
	}
	else
		printf("\tFailed.");

	printf("\n2.3 isPositive");
	if (isPositive(10) == 1 && isPositive(-5) == 0 && isPositive(0) == 0)
	{
		printf("\tPass.");
		score += 3;
	}
	else
		printf("\tFailed.");

	printf("\n2.4 isGE2n");
	if (isGE2n(4, 1) == 1 && isGE2n(8, 3) == 1 && isGE2n(12, 4) == 0)
	{
		printf("\tPass.");
		score += 3;
	}
	else
		printf("\tFailed.");

	printf("\n--- FINAL RESULT ---");
	printf("\nScore: %.1f", (float)score / 2);
	if (score < 5)
		printf("\nTrouble when solving these problems? Contact your instructor to get some hints :)");
	else
	{
		if (score < 8)
			printf("\nNice work. But try harder.");
		else
		{
			if (score >= 10)
				printf("\nExcellent. We found a master in bit-wise operations :D");
			else
				printf("\nYou're almost there. Think more carefully in failed problems.");
		}
	}

	printf("\n\n\n");
}