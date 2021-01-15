// #include<bits/stdc++.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>
#include<stdio.h>
// using namespace std;
void copy(char *a, char* b)
{
	for(int i=0; i<strlen(b); i++)
	{
		a[i] = b[i];
	}
}
void readCommand()
{
	while(1)
	{
		char str[100];
		gets(str);
		int a=strcmp("exit", str);
		int b=strcmp("log",str);
		int c=strcmp("unlog", str);
		int d=strcmp("viewcmdlog", str);
		int e=strcmp("viewoutlog", str);
		int f =strcmp("changedir", str);
		// if(a) exitCmd();
		// else if(b) logCmd();
		// //write for all such internal cmds


		
		
			//external commands
			char temp[100][100];
			char * token = strtok(str, " ");
		   // loop through the string to extract all other tokens
		    int countPipe=0;
		    int pos=0;
		    while( token != NULL ) 
		    {
		    	printf("%s\n",token );
		    	if(strcmp(token, "|")==0) countPipe++;
		       copy(temp[pos++], token);
		       token = strtok(NULL, " ");
		    }
		   	copy(temp[pos++], "|");
		    char *execArg[100];
		    int pipeIterator=0;
		    int pipeIndex=0;
		    int flag=0;
		    countPipe++;
		    while(countPipe--)
		    {
			    int k=0;
			    for(int i=0;strcmp(temp[i+pipeIndex],"|")!=0; i++)
			    {
			    	execArg[i] = (char*)malloc(sizeof(strlen(temp[i+pipeIndex])));
			    	copy(execArg[i], temp[i+pipeIndex]);
			    	k++;

			    	printf("%s\n", execArg[0]);
			    }
			    // printf("\n", );
			    pipeIndex = k+pipeIndex+1;
			    // strcpy(execArg[k],NULL);
				printf("ERE %d\n", countPipe);
				int lol = fork();
				if(lol==0)
				{
					int what = 0;
					int x = execvp(execArg[0], execArg);
					what=1;
					// cout<<"Command Doesn't Exist"<<endl;
					exit(what);
				}
				else
				{
					int retVal;
					waitpid(lol, &retVal, 0);
					if(retVal!=0) break;
				}

		    }

		
		exit(0);
	}
}
int main()
{
	char str[100];
	while(1)
	{
		gets(str);
		if(strcmp(str, "entry")==0)
			break;
		// else cout<<"Command Line Interpreter Not Started"<<endl;
	}
	int x = fork();
	if(x==0)
	{
		readCommand();
	}
	wait(NULL);
}