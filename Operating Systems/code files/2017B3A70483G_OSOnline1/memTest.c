#include "memInterface.h"
#include<stdio.h>
FinalScore memTest(FILE* fp1, FILE* fp2, int* BobMem, int k)
{
	FinalScore ans;
	
	int x;
	char dum;
	while(fscanf(fp1, "%d", &x)!=EOF)
	{
		if(x==1)
		{
			dum = fscanf(fp1, "%c", &dum);
			int num;
			fscanf(fp1, "%d", &num);
			addToMemory(BobMem, &ans, k, num);
		}
		else if(x==2)
		{
			printMemoryState(fp2, BobMem, ans,k );
		}
		else if(x==3)
		{
			printScore(fp2, ans);
		}
		else
		{
			fprintf(fp2, "Last attempt number was:%d Error[queryHandler fails]:Unknown Query Type.\n",ans.attempt );
		}
		dum = fscanf(fp1, "%c", &dum); //for enter

	}
	return ans;
}