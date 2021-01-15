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
#include <fcntl.h>

#include<stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
// using namespace std;
void copy(char *a, char *b)
{
    for(int i = 0; i < strlen(b); i++)
    {
        a[i] = b[i];
    }
}

// 1. New Command: stdout ->in a file.
//    Piped command : input from file and  -> file /// using dup2()


// ls -l | grep more | grep lol
// ls -l ->   stdin: temp1 stdout: temp2 -> copy to temp1
// grep more: stdin: temp1 stdout: temp2 -> copy to temp1
// grep lol : stdin: temp1 stdout: temp2 -> copy to temp1

//stdout -> temp1
// dup2(Old Desc, new Desc);
// duo2(temp1, 1)
// void copyFile(FILE* target, FILE* )
// {

//    // return 0;
// }
void readCommand()
{
    int fd1 = open("temp1.txt", O_RDWR );
    int fd2 = open("temp2.txt", O_RDWR);
    printf("fd1: %d fd2:%d\n", fd1, fd2 );
    while(1)
    {
        char str[100];
        gets(str);
        int a = strcmp("exit", str);
        int b = strcmp("log", str);
        int c = strcmp("unlog", str);
        int d = strcmp("viewcmdlog", str);
        int e = strcmp("viewoutlog", str);
        int f = strcmp("changedir", str);
        // if(a) exitCmd();
        // else if(b) logCmd();
        // //write for all such internal cmds
        //external commands
        char temp[100][100];
        char *token = strtok(str, " ");
        // loop through the string to extract all other tokens
        int countPipe = 0;
        int pos = 0;
        while( token != NULL )
        {
            printf("%s\n", token );
            if(strcmp(token, "|") == 0) countPipe++;
            copy(temp[pos++], token);
            token = strtok(NULL, " ");
        }
        copy(temp[pos++], "|");
        char *execArg[100];
        int pipeIterator = 0;
        int pipeIndex = 0;
        int flag = 0;
        countPipe++;
        while(countPipe--)
        {
            int k = 0;
            for(int i = 0; strcmp(temp[i + pipeIndex], "|") != 0; i++)
            {
                execArg[i] = (char *)malloc(sizeof(strlen(temp[i + pipeIndex])));
                copy(execArg[i], temp[i + pipeIndex]);
                k++;

            }
            // printf("\n", );
            execArg[k] = (char *)NULL;
            pipeIndex = k + pipeIndex + 1;
            // strcpy(execArg[k],NULL);
            printf("ERE %d\n", countPipe);
            printf("0: %s 1: %s\n", execArg[0], execArg[1] );
            int lol = fork();
            if(lol == 0)
            {
                dup2(fd1, 0);
                dup2(fd2, 1);

                int what = 0;
                int x = execvp(execArg[0], execArg);
                printf("%d \n", what);
                what = 1;
                // cout<<"Command Doesn't Exist"<<endl;

                exit(what);
            }
            else
            {
                int retVal;
                wait(&retVal);
                FILE *f1 = fopen("temp1.txt", "w");
                FILE *f2 = fopen("temp2.txt", "r");
                FILE *source, *target;
                source = fopen("temp2.txt", "r");
                char ch;
                target = fopen("temp1.txt", "w");

                while( ( ch = fgetc(source) ) != EOF )
                    fputc(ch, target);
                fclose(source);
                fclose(target);
                if(retVal != 0) break;
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
        if(strcmp(str, "entry") == 0)
            break;
        // else cout<<"Command Line Interpreter Not Started"<<endl;
    }
    int x = fork();
    if(x == 0)
    {
        readCommand();
    }
    wait(NULL);
}