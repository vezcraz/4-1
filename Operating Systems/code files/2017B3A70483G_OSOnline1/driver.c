#include<stdio.h>
#include "memInterface.h"


int main(int argc, char **argv)
{
	int k = argv[1][0]-'0';
	FILE* fp1 = fopen(argv[2], "r+"); //input1
	FILE* fp2 = fopen(argv[3], "r+"); //input2
	FILE* fpw = fopen(argv[4], "w+");
	int BobMem[k];
	initializeMemory(fp1, BobMem, k);
	FinalScore ans = memTest(fp2, fpw, BobMem, k );

}