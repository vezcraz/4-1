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

void readCommand(){
    FILE* f1 = fopen("temp1.txt", "w");
    FILE* f2 = fopen("temp2.txt", "w");
    fclose(f1);
    fclose(f2);
    while(1){
        char str[100];
        gets(str);
        int a = strcmp("exit", str);
        int b = strcmp("log", str);
        int c = strcmp("unlog", str);
        int d = strcmp("viewcmdlog", str);
        int e = strcmp("viewoutlog", str);
        int f = strcmp("changedir", str);
        //If for internal commands. Else for external commands.
        char temp[100][100];
        char *token = strtok(str, " ");
        int countPipe = 0;
        int pos = 0;
        while(token != NULL ){
            printf("%s\n", token);
            if(strcmp(token, "|") == 0) 
                countPipe++;
            strcpy(temp[pos++], token);
            token = strtok(NULL, " ");
        }
        strcpy(temp[pos++], "|");
        char *execArg[100];
        int pipeIndex = 0;
        countPipe++;
        while(countPipe--){
        printf("Command Doesn't Exist %d\n", countPipe);
            int k = 0;
            for(int i = 0; strcmp(temp[i + pipeIndex], "|")!= 0; i++){
                execArg[i] = (char *)malloc(sizeof(strlen(temp[i + pipeIndex])));
                strcpy(execArg[i], temp[i + pipeIndex]);
                k++;
            }
            execArg[k] = (char *)NULL;
            pipeIndex = k + pipeIndex + 1;
            printf("0: %s 1: %s\n", execArg[0], execArg[1] );
            int fdin, fdout;
            if(countPipe&1){
                fdin  = open("temp1.txt", O_RDONLY);
                fdout = open("temp2.txt", O_WRONLY|O_TRUNC);
            }
            else{
                fdout  = open("temp1.txt", O_WRONLY|O_TRUNC);
                fdin = open("temp2.txt", O_RDONLY);
            }
            int lol = fork();
            if(lol == 0){
                printf("%d %d\n", fdin, fdout);
                dup2(fdin, 0);
                dup2(fdout, 1);
                int exitVal = 0;
                int x = execvp(execArg[0], execArg);
                exitVal = 1;
                exit(exitVal);
            }
            int retVal;
            wait(&retVal);
            if(retVal != 0) 
                break;
        }
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
        else
            printf("Command Line Interpreter Not Started\n");
    }
    int x = fork();
    if(x == 0)
    {
        readCommand();
    }
    
    wait(NULL);
}