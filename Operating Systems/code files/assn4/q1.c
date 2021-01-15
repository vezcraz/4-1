// #include<bits/stdc++.h>
#include<pthread.h>
#include<asm/unistd.h>
#include<sys/syscall.h>
#include<stdio.h>
int a[100][100], b[100][100], c[100][100];
int m,k,n;
void input(int v[][100],int x, int y)
{
	for(int i=0; i<x; i++)
	{
		for(int j=0; j<y; j++)
		{
			scanf("%d", &v[i][j]);
		}
	}
}
void print(int x)
{
	printf("%d \n", x);
}
void* runner(void* lol)
{
	int *arr = (int*)lol;

	int sum=0;
	int row = arr[0], col = arr[1];
	for(int i=0; i<k; i++)
	{
		sum+= a[row][i] * b[i][col];
	}
	c[row][col]=sum;
	// print(sum);
	pthread_exit(0);

}
int main()
{

	scanf("%d%d%d", &m, &k, &n);
	// input(a,m,k);
	// input(b,k,n);
	for(int i=0; i<m; i++)
	{
		for(int j=0; j<k; j++)
		{
			scanf("%d", &a[i][j]);
		}
	}
	for(int i=0; i<k; i++)
	{
		for(int j=0; j<n; j++)
		{
			scanf("%d", &b[i][j]);
		}
	}
	pthread_t tidArr[m*n];
	pthread_attr_t x;
	pthread_attr_init(&x);
	int arr[m*n][2];
	for(int i=0; i<m; i++)
	{
		for(int j=0; j<n; j++)
		{
			arr[n*i+j][0]=i;
			arr[n*i+j][1]=j;

		}
	}
	int cx=0;
	for(int i=0; i<m; i++)
	{
		for(int j=0; j<n; j++)
		{
			pthread_create(&tidArr[cx],&x,runner,(void*)(arr[cx]));
			cx++;

		}
	}
	for(int i=0; i<m*n; i++)
		pthread_join(tidArr[i], NULL);
	for(int i=0; i<m; i++)
	{
		for(int j=0; j<n; j++)
			printf("%d ", c[i][j]);
		printf("\n");
	}

}