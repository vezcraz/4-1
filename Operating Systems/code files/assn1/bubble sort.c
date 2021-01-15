#include<stdio.h>
#include "sort.h"

void swap(int *a, int *b)
{
	int t = *b;
	*b=*a;
	*a = t;
}
void bubblesort(int *v, int n)
{
	printf("Bubble_Sort: ");
	for(int i=0; i<n-1 ;i++)
	{
		for(int j=0; j<n-i-1; j++)
		{
			if(v[j]>v[j+1])swap(&v[j], &v[j+1]);
		}
	}
}