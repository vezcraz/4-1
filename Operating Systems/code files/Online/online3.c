#include<stdio.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>

#define NEXTBALL (SIGRTMIN+1)
#define SHOTHIT (SIGRTMIN+2)

//Ball result SIGRTMIN +3 till SIGRTMIN + 10
#define NEXTOVER (SIGRTMIN+11)
#define INNINGSOVER (SIGRTMIN+12)
#define BALLBOWLED (SIGRTMIN+13)

struct ScoreBoard
{
	int runs, wickets, balls;
};
struct PersonalScore
{
	int runs=0, wickets=0;
};
struct shared
{
	int bat; //which team bats
	int bowl;
	int p1[11], p2[11];
	int pidBatStrike, pidBatNonStrike, pidBowl; //pids of current bowler , batsmen
//who is in strike
	int batIndexStrike=0, bowlIndex=6, batIndexNonStrike=1;
//current player seed
	int batSeed,  bowlSeed; 
//seed of all
	int batSeedArr[11], bowlSeedArr[11];
//who all are out
	int out[11];
	ScoreBoard *sb;
	PersonalScore *ps[11];
};

struct shared *f;
//just for printing
	void print(int x) {printf("%d\n",x ); } 
	void printString(char *x) {printf("%s\n",x ); }
void swapStrike()
{
//pid swap
	int temp = f->pidBatStrike;
	f->pidBatStrike = f->pidBatNonStrike;
	f->pidBatNonStrike = temp;
//seed update for current batsman
	f->batSeed = f->batSeedArr[f->batIndexNonStrike];
//index swap
	temp = f->pidBatStrike;
	f->batIndexStrike = f->batIndexNonStrike;
	f->batIndexNonStrike = temp;
}
//signal handlers
void nextBall(int sig)
{
	kill(f->pidBatStrike, BALLBOWLED);
}
void shotHit(int sig)
{
	int seed = f->bowlSeed + f->batSeed + f->sb->balls;
	srand();
	int runs = rand()%8;
	if(runs==7)
	{
		f->sb->wickets++;
//process should be actually killed and 
//a new process should be created for the batsman
	}
	else f->sb->runs+=runs;
	kill(f->pidBatStrike, SIGRTMIN + runs +3);
}
void ballResult(int sig)
{
	int runs = sig -3-SIGRTMIN;
	if(runs%7==0)
	{
		//kill process of batsman; make new batsman 
		f->out[batIndexStrike] = 1;
		f->ps[bowlIndex]->wickets++; //increment bowler ka wickets taken
		for(int i=0; i<11; i++)
		{
			if(f->out[i]==0) //if batsman not out then use this now
			{
				f->batIndexStrike = i;
				break;
			}
		}
		return;
	}
	//change strike
	else if(runs&1)
	{
		swapStrike();
		 f->ps[batIndexStrike]->runs+=runs; //increment personal score

	} 
	else
		 f->ps[batIndexStrike]->runs+=runs;  //--do--
	//kill
}
void nextOver(int sig)
{
//swap strike
	int temp = f->pidBatStrike;
	f->pidBatStrike = f->pidBatNonStrike;
	f->pidBatNonStrike = temp;
//randomly select next bowler
	int seed = f->bowlSeed + (f->sb->balls)/6;
	srand(seed);
	f->bowlIndex = 6+ rand()%6;
	f->bowlSeed = f->bowlSeedArr[bowlIndex];
}
void inningsOver(int sig)
{

}
void ballBowled(int sig)
{
	kill(f->pidUmpire, SHOTHIT);
}
void batsman(struct shared* f, int strike)
{
	raise(SIGSTOP);
	if(strike)
		f->pidBatStrike = getpid();
	else f->pidBatNonStrike = getpid();
	raise(SIGSTOP);
	int isStriker=strike;
	signal(BALLBOWLED, ballBowled);
	for(int i=3; i<=10; i++){
		signal(SIGRTMIN+i, ballResult);
	}
	
}

void bowler(struct shared* f)
{
	f->pidBowl = getpid();
	raise(SIGSTOP);
	signal(NEXTBALL, nextBall);
	for(int i=3; i<=10; i++){
		signal(SIGRTMIN+i, ballResult);
	}
	
}
void team(struct shared* f, char *filename, int id)
{

	int tid  = id;
	signal(NEXTOVER, nextOver);
	signal(INNINGSOVER, inningsOver );
//input (Working if removed everything _/\_)
	FILE* fin = fopen(filename, "r");
	char name[20]; int seed;
	fscanf(fin,"%s", name);
	fscanf(fin,"%d", &seed);
	char player[11][20]; int playerSeed[11];
	for(int i=0; i<11; i++)
	{
		fscanf(fin,"%s", player[i]);
		// printString(player[i]);
	}
	for(int i=0; i<11; i++)
	{
		fscanf(fin,"%d", &playerSeed[i]);
	}
//functionality
//create batsman if f->bat==tid	
	if(f->bat==tid)
	{
		f->batSeed = playerSeed[0];
		int p1 = fork();
		if(p1==0) batsman(f,1);

		int p2 = fork();
		if(p2==0) batsman(f, 0);
	}
//else make a bowler
	else 
	{
		f->bowlSeed = playerSeed[6];
		int p = fork();
		if(p==0) bowler(f);
	}
	raise(SIGSTOP);




	exit(0);

}

void umpire(struct shared* f)
{
//accepts
	signal(SHOTHIT, shotHit);
//input from file	
	FILE* fin = fopen("umpire.txt", "r");
	int seed, overs;
	fscanf(fin,"%d", &seed);
	fscanf(fin,"%d", &overs);
	print(seed);
	print(overs);
//stop it for main	
	raise(SIGSTOP);
//set seed and toss
	srand(seed);
	int toss = rand()%2;
//who bats and who bowls
	if(toss) f->bat = 1, f->bowl= 2;
	else f->bat = 2, f->bowl = 1;
//give signal for nextball
	for(int i=0; i<6*overs;i++)
	{
		f->sb->bowl++;
		kill(f->pidBowl, NEXTBALL);

		if(i%6==0)
		{
			kill(f->pidBatStrike, NEXTOVER);
			kill(f->pidBowl, NEXTOVER);
		}
	}
	exit(0);

}

int main()
{
	int shmid = shmget(IPC_PRIVATE, sizeof(struct shared), 0666 | IPC_CREAT);
    f = (struct shared *)shmat(shmid, (void *)0, 0);
//umpire creation
	int u = fork();
	if(!u)
	{
		umpire(f);
	}
//t1 creation
	int t1 = fork();
	if(!t1) team(f, "team1.txt", 1);
//t2 creation	
	int t2 = fork();
	if(!t2) team(f, "team2.txt", 2);

	for(int i=0; i<3; i++)
	{
		waitpid(-1, NULL, WUNTRACED);
	}
	kill(u, SIGCONT):
}