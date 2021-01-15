#include "sort.h"
#include<stdio.h>
#include<string.h>
int a=5;
int main(int argc, char **argv)
{
	//0 input file 1 output file 2 is option
	FILE *fr = fopen(argv[1], "r+");
	FILE* fw = fopen(argv[2], "a+");
	int n;
	fscanf(fr, "%d", &n);
	int v[n];
	char dum;
	fscanf(fr, "%c", &dum);
	for(int i=0; i<n; i++) fscanf(fr, "%d", &v[i]);
	if(strcmp(argv[3], "bubble")==0) bubblesort(v,n);
	else if(strcmp(argv[3], "insertion")==0) insertionsort(v,n);
	fprintf(fw, "\n%s\n", argv[3]);
	for(int i=0; i<n; i++) fprintf(fw, "%d ", v[i]);
    
	fclose(fr);
	fclose(fw);
}