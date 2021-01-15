#include<stdio.h>
#ifndef _MEMORY_TEST_BOB
#define _MEMORY_TEST_BOB
typedef struct FinalScore
{
	int score;
	int attempt;
}FinalScore;

extern void initializeMemory(FILE *fp,int *BobMem, int k);
extern FinalScore memTest(FILE *fp1, FILE *fp2, int *BobMem, int k);
extern void printMemoryState(FILE* fp, int *BobMem, FinalScore res, int k);
extern void printScore(FILE* fp, FinalScore ans);
extern void addToMemory(int *BobMem, FinalScore* res, int k, int num );
#endif