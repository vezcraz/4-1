#include "memInterface.h"
#include<stdio.h>
void initializeMemory(FILE* fp,int *BobMem, int k)
{
	int c=0;
	char dum;
	int x;
	for(int i=0; i<k; i++) BobMem[i]=-1;
	int done[100000];
	while(fscanf(fp, "%d", &x)==1)
	{
		if(c==k) break;
		dum = fscanf(fp, "%c", &dum);
		if(done[x]) continue;
		BobMem[c++]=x;
		done[x]=1;
	}
	// for(int i=0; i<k; i++)
	// 	printf("%d\n", BobMem[i] );
}