#include "memInterface.h"
#include<stdio.h>

void printScore(FILE* fp, FinalScore res)
{
	fprintf(fp, "Current Score: %d and Attempts: %d\n", res.score, res.attempt);
}