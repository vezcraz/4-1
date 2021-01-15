#include "sort.h"
#include<stdio.h>

void shift(int pos, int end, int *v)
{
	for(int i=end; i>=pos; i--) v[i+1]=v[i];
}
void insertionsort(int *v, int n)
{
	fprintf(stderr, "%s", "insertion_sort: ");
	for(int i=1; i<n ;i++)
	{
		for(int j=0; j<i;j++)
		{
			if(v[j]>=v[i])
			{
				int el = v[i];
				shift(j, i-1, v);
				v[j]=el;
			}
		}
	}
}