#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>
#include<stdio.h>
#include <fcntl.h>
#include <time.h> 	
#include <sys/time.h>

#define max(a, b) (((a)>(b)) ? (a) : (b))
#define min(a, b) (((a)<(b)) ? (a) : (b))

pid_t ticektGuy = 0;
int ticketQueue = 0;  
int pickupQueue = 0; 

void T2QexecByQueue(int sig){
	printf("%d", sig);
	int received = sig - SIGRTMIN;
	int available = 20 - pickupQueue;
	if(received < available){
		 fprintf(stderr, "%d people sent to queue\n",received);
		 pickupQueue += (received);
		 kill(ticektGuy, SIGRTMIN+received);
	}
	else{
		fprintf(stderr,"%d people sent to queue\n",available);
		kill(ticektGuy, SIGRTMIN+available);
		pickupQueue+=available;
	}
}

void Q2TexecByTicket(int sig){
		printf("%d", sig);

	int takenIntoQueue = sig - SIGRTMIN;
	ticketQueue-=takenIntoQueue;
}
void D2QexecByQueue(int sig){
		printf("%d", sig);

	fprintf(stderr, "Queue Size before ride: %d \n",pickupQueue);
	pickupQueue=max(0, pickupQueue-(sig-SIGRTMIN-20));
	fprintf(stderr, "Queue Size after ride: %d \n",pickupQueue);
}

void ticket(){ // 6 Signal min(20,ticketQueue)
	for(int i=1; i<=20; i++){
		signal(SIGRTMIN+i, Q2TexecByTicket);
	}
	int groupSize = 0;
	raise(SIGSTOP);
	L1:
	groupSize = 1+rand()%6; //SIGRTMIN+1 - SIGRTMIN + 5
	fprintf(stderr, "%d people bought a ticket\n",groupSize);
	ticketQueue+=groupSize;
	kill(getppid(), SIGRTMIN + min(20,ticketQueue));
	int sleeptime = 0;
	sleeptime = 5+rand()%16;
	sleep(sleeptime);
	goto L1;
}

void driver(){
	raise(SIGSTOP);
	int emptySeats = 0;
	L2:
	emptySeats = 1+rand()%7;
	fprintf(stderr, "Ride Capacity: %d \n",emptySeats);
	kill(getppid(), SIGRTMIN +20+ emptySeats);
	int sleeptime = 0;
	sleeptime = 10+rand()%6;
	sleep(sleeptime);
	goto L2;

}
float timedifference_msec(struct timeval t0, struct timeval t1)
{
    return (t1.tv_sec - t0.tv_sec) * 1000.0f + (t1.tv_usec - t0.tv_usec) / 1000.0f;
}


int main(){ // Queue
	for(int i=1; i<=20; i++){
		signal(SIGRTMIN+i, T2QexecByQueue);
	}
	for(int i=1; i<=7; i++){
		signal(SIGRTMIN+i+20, D2QexecByQueue);
	}
	int x = fork();
	if(x == 0){
		ticket();
	}
	int y = fork();
	if(y == 0){
		driver();
	}
	waitpid(x, NULL, WUNTRACED);
	waitpid(y, NULL, WUNTRACED);
	kill(x, SIGCONT);
	kill(y, SIGCONT);
	struct timeval start;
   	struct timeval end;
   	gettimeofday(&start, 0); 
   	gettimeofday(&end,0);
	
	int waiter = fork();
	// fprintf(stderr, "here");
	if(!waiter)
	{
		sleep(100);
		kill(x, SIGKILL);
		kill(y, SIGKILL);
		kill(getppid(), SIGKILL);
		exit(0);
	}
	while(1)
	{

	}
	return 0;
}





