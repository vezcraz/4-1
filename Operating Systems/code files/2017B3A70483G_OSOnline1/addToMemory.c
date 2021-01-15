#include "memInterface.h"
#include<stdio.h>

void addToMemory(int *BobMem, FinalScore *res, int k, int num)
{
	int present=(num==BobMem[0]);
	for(int i=k-1; i>=0; i--)
	{
		if(BobMem[i]==num) present |=1;
		BobMem[i+1]=BobMem[i];
	}
	BobMem[0]=num;
	if(present) res->score++;
	res->attempt++;
	
}