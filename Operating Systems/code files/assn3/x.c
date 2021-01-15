#include<stdio.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>
 
int n;
int f=0;
void createDishes(int *time, int *dishes , int* pidArr, int node, int g[][n+1]){
	int ret=0;
	sleep(time[node]);
	ret = dishes[node];
	exit(ret);
}
 
void func(int *time, int *dishes , int* pidArr, int node, int g[][n+1], int* dishesArray){	
	fprintf(stderr, "Running node %d\n", node);
	int x = fork();
	if(x == 0){
		dishesArray[node] = getpid();
		createDishes(time, dishes, pidArr, node, g);
	}
	int retVal = 0;
	waitpid(x, &retVal, 0);
	retVal/=256;
	if(getpid() == pidArr[1]){
		for(int i=2; i<=n; i++){
			kill(dishesArray[i], SIGKILL);
		}
	}
	if(retVal==0){
			fprintf(stderr,"Chef #%d-> #dishes made: %d, #dishes collected: %d\n", node, 0, 0);
			exit(0);
	}
	int sum = 0;
	int retVal2 = 0;	
	while(wait(&retVal2)!=-1){
		sum+=retVal2/256;
	}
	fprintf(stderr,"Chef #%d-> #dishes made: %d, #dishes collected: %d\n", node, retVal, sum);
	exit(sum+retVal);
}
 
int main()
{
	FILE* f = fopen("input.txt", "r");
	fscanf(f, "%d", &n);
 	printf("%d\n", n);
	int g[n+1][n+1];
	memset(g, 0, sizeof(g));
 				///Shared Mem
	for(int i=0; i<n-1; i++)
	{
		int from, to;
		fscanf(f, "%d", &from);
		fscanf(f, "%d", &to);
		printf("%d %d\n", from, to);
		g[from][to] = 1;
	}
	int time[n+1], dishes[n+1];
	for(int i=1; i<=n; i++)
	{
		fscanf(f, "%d", &dishes[i]);
	}
	for(int i=1; i<=n; i++)
	{
		fscanf(f, "%d", &time[i]);
	}
	
	int curr=1;
	int shmid = shmget(IPC_PRIVATE, (n+1)*sizeof(int), 0666 | IPC_CREAT);
	int shmid2 = shmget(IPC_PRIVATE, (n+1)*sizeof(int), 0666 | IPC_CREAT);
	int *dishesArray = (int*)shmat(shmid2, 0, 0);
	int *pidArr = (int*)shmat(shmid, 0, 0);
	int head = fork();
	if(head==0)
	{
		printf("Node No: %d,I am: %d, My parent is: %d\n", 1, getpid(), getppid());
		pidArr[1] = getpid();
		for(int i=1; i<=n; i++)
		{
			if(g[curr][i]==1)
			{
				int x = fork();
				if(!x)
				{
					printf("Node No: %d,I am: %d, My parent is: %d\n", i, getpid(), getppid());
					fflush(stdout);
					curr =i ;
					i=0;
					pidArr[curr] = getpid();
				}
			}
		}
		//curr is the node no.
		kill(getpid(), SIGSTOP);
		func(time, dishes, pidArr, curr, g, dishesArray);
	}
	while(1)
	{
		int flag=1;
		for(int i=1; i<=n; i++)
		{
			if(pidArr[i]==0)
			{
				flag=0;
				break;
			}
		}
		if(flag) break;
	}
	kill(pidArr[1], SIGCONT);
	for(int i=2; i<=n; i++)
	{
		kill(pidArr[i], SIGCONT);
	}
	int ans=0;
	wait(&ans);
	printf("Total Worthy Dishes = %d\n", ans/256);
	for(int i=1; i<=n; i++)
	{
		printf("%d\n", pidArr[i]);
	}
	shmdt(pidArr);
	shmctl(shmid, IPC_RMID, NULL);
}
 
 
 
// Main Process:
// Head Pricess + Sub Chefs -> Separete red pricess that executes sleep.
// Whenecer head is done it sends kill to these red process so that my subchef tree is maintained and the values that are there in the retVak are wither 0 (When Head kills red process) or the number of dishes created(Whenever it exits on ots own.
 
 
 
			
 
 
 
 
 