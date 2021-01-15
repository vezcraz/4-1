#include "memInterface.h"
#include<stdio.h>

void printMemoryState(FILE* fp, int *BobMem, FinalScore res, int k)
{
	int last = res.attempt;

	fprintf(fp, "Last attempt was:%d\n", last );
	fprintf(fp, "Current state is: " );
	for(int i=0; i<k; i++)
	{
		if(BobMem[i]==-1) break;
		fprintf(fp,"%d ", BobMem[i]);
	}
	fprintf(fp, "\n" );
}