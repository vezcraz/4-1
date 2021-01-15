#include<stdio.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>

struct shared
{
	int bat;
	int bowl;
};
void print(int x)
{
	printf("%d\n",x );
}
void printString(char *x)
{
	printf("%s\n",x );
}
void team1()
{
	FILE* fin = fopen("team1.txt", "r");
	char name[20]; int seed;
	fscanf(fin,"%s", name);
	fscanf(fin,"%d", &seed);
	char player[11][20]; int playerSeed[11];
	for(int i=0; i<11; i++)
	{
		fscanf(fin,"%s", player[i]);
	}
	for(int i=0; i<11; i++)
	{
		fscanf(fin,"%d", &playerSeed[i]);
	}
	raise(SIGSTOP);
	exit(0);

}
void team2()
{
	FILE* fin = fopen("team2.txt", "r");
	char name[20]; int seed;
	fscanf(fin,"%s", name);
	fscanf(fin,"%d", &seed);
	char player[11][20]; int playerSeed[11];
	for(int i=0; i<11; i++)
	{
		fscanf(fin,"%s", player[i]);
	}
	for(int i=0; i<11; i++)
	{
		fscanf(fin,"%d", &playerSeed[i]);
	}
	raise(SIGSTOP);
	exit(0);
	
}

void umpire()
{
//t1 creation
	int t1 = fork();
	if(!t1) team1();
//t2 creation	
	int t2 = fork();
	if(!t2) team2();
//wait for them
	for(int i=0; i<2; i++)
	{
		waitpid(-1, NULL, WUNTRACED);
	}
//input from file	
	FILE* fin = fopen("umpire.txt", "r");
	int seed, overs;
	fscanf(fin,"%d", &seed);
	fscanf(fin,"%d", &overs);
	print(seed);
	print(overs);
	
	raise(SIGSTOP);
// //set seed and toss
// 	srand(seed);
// 	int toss = rand()%2;
// //who bats and who bowls
// 	if(toss) f->bat = 1, f->bowl= 2;
// 	else f->bat = 2, f->bowl = 1;
	exit(0);

}

int main()
{
	int u = fork();
	if(!u)
	{
		umpire();
	}
	waitpid(u, NULL, WUNTRACED);


}