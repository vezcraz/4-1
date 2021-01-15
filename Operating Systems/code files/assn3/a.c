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
int killSubtree(int node, int g[][n+1],int *pidArr)
{
	int leaf=1;
	for(int i=1; i<=n; i++)
	{
		if(g[node][i])
		{
			leaf=0;
			killSubtree(i,g, pidArr);
		}
	}
	kill(pidArr[node], SIGKILL);
}
void func(int *time, int *dishes , 
	int* pidArr, int node, int g[][n+1])
{
	int ret=0;
	sleep(time[node]);
	ret = dishes[node];
	fprintf(stderr,"Running node %d %d\n", node, time[node]);
	int sum=0;
	for(int i=1; i<=n; i++)
	{
 
		if(g[node][i])
		{
			int retVal;
			int x = waitpid(pidArr[i], &retVal, WNOHANG);
			if(x!=0){
				sum+= retVal/256;
			}
			else
				killSubtree(i,g, pidArr);

		}
	}

	fprintf(stderr,"Chef #%d-> #dishes made: %d, #dishes collected: %d\n",
	 node, , sum );
	while(wait(NULL)!=-1);
	exit(ret?(ret+sum):0);
}
int main()
{
	FILE* f = fopen("input.txt", "r");
	
	fscanf(f, "%d", &n);
 	printf("%d\n", n);
	int g[n+1][n+1];
	memset(g, 0, sizeof(g));
 
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
		func(time, dishes, pidArr, curr, g);
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
	shmdt(pidArr);
	shmctl(shmid, IPC_RMID, NULL);
 	
 
}