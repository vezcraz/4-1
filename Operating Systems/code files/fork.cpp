#include<bits/stdc++.h>
#include<unistd.h>
#include<sys/types.h>
#include<errno.h>
#include<sys/wait.h>
using namespace std;
int main()
{
	int x;
	x = fork();
	int retStat;
	int val=100;
	if(x<0) perror("fork failed\n");
	else if(x==0){
		cout<<"Child Process"<<endl;
		cout<<getpid()<<" "<<x<<" "<<getppid()<<endl;
		val+=200;
		cout<<val<<endl;
		cout<<endl;
		exit(760); // exit statement exits and returns this value.
	}
	else
	{
		cout<<"Parent Process"<<endl;
		cout<<getpid()<<" "<<x<<endl;
		val+=500;
		cout<<val<<endl;
		cout<<endl;
		int retval=wait(&retStat); //helps to get the returned value of the child
		cout<<"Returning Process:(the child)  "<<retval<<endl;
		cout<<"Returned Value : " <<retStat/256<<endl; //returned status is (256*(767%256))
		// wait(NULL); //used for waiting for the child to get executed. 
		// orphan nhi banana usko
	}
	return 34;
}
