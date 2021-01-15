#include<stdio.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>
#include <iostream>
using namespace std;

int n;
#define bound 100000
struct Score
{
	int pidArr[bound];
	int against[bound];
	int goals[bound];
	int points[bound];
	int playing[bound];
};
void printArr(int a[], int n)
{
	for(int i=0; i<n ;i++)
	{
		cout<<a[i]<<" ";
	}
	cout<<endl;
}
void simulate(int i, struct Score* f)
{
	srand(getpid());
	top:
	raise(SIGSTOP);
	int home = i, away = f->against[i];
	// printArr(f->against, n);
	cout.flush()<<"Starting Match "<<home<<" "<<away<<"\n";
	sleep(3);

	int goals_home = rand()%6, goals_away = rand()%6;
	f->goals[home] += goals_home, f->goals[away] += goals_away;
	
	if(goals_home>goals_away) f->points[home]+=3; 
	else if(goals_home==goals_away) f->points[home]+=1, f->points[away]++; 
	else f->points[away]+=3;
	f->playing[home]=0, f->playing[away]=0;

	cout.flush()<<"Ending Match "<<f->playing[home]<<" "<<f->playing[away]<<" "<<home<<" "<<away<<" Result "<<goals_home<<" - "<<goals_away<<endl;
	goto top;
}
void initialise(struct Score* f, int schedule[][3])
{
	memset(f->against, 0 , sizeof(f->against));
	memset(f->pidArr, 0, sizeof(f->pidArr));
	memset(f->goals, 0, sizeof(f->goals));
	memset(f->points, 0, sizeof(f->points));
	memset(f->playing, 0, sizeof(f->playing));
	for(int i=0;i<n*(n-1) ; i++)
	{
		int home, away;
		cin>>home>>away;
		schedule[i][0] = home;
		schedule[i][1] = away;
		schedule[i][2]=0;
	}
}

int main()
{

    freopen("./input.txt", "r", stdin); 
    // freopen("./output.txt", "w", stdout);

	cin>>n;
	int schedule[n*(n-1)][3];
	int shmid = shmget(IPC_PRIVATE, sizeof(struct Score), 0666 | IPC_CREAT);
	struct Score* f = (struct Score*)shmat(shmid, 0, 0);
	initialise(f, schedule);

	for(int i=1; i<=n; i++)
	{
		pid_t x = fork();
		if(!x) simulate(i,f);
		else 
			f->pidArr[i]=x;
	}
	int c=0;
	int count=0;
	while(count!= n*(n-1))
	{
		// cout<<count<<" "<<c<<endl;
		int home = schedule[c][0];
		int away = schedule[c][1];
		int done = schedule[c][2];
		if(done==0 and f->playing[home]==0 and f->playing[away]==0)
		{
			f->playing[home]=1, f->playing[away]=1;
			count++;
			f->against[home] = away;
			// cout<<f->against[home]<<endl;
			waitpid(f->pidArr[home], NULL, WUNTRACED);
			kill(f->pidArr[home], SIGCONT);
			schedule[c][2]=1;
		}
		c= (c+1)%(n*(n-1));
	}
	for(int i=1; i<=n; i++)
	{
		waitpid(f->pidArr[i], NULL, WUNTRACED);
	}
	int pi=0, gi=0, mxi;
	for(int i=1; i<=n; i++)
	{
		if(pi<f->points[i]) 
		{
			pi = f->points[i];
			gi = f->goals[i];
		}
		else if(pi==f->points[i])
		{
			if(f->goals[i]>gi)
			{
				pi = f->points[i];
				gi = f->goals[i];
			}
		}
	}
	cout<<n<<endl;
	shmdt(f);
	shmctl(shmid, IPC_RMID, NULL);
 	

}