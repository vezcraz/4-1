#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>

int main() {
   // char string[50] = "Hello!          We are learning about strtok";
   // // Extract the first token
   // char * token = strtok(string, " ");
   // // loop through the string to extract all other tokens
   // while( token != NULL ) {
   //    printf( " %s\n", token ); //printing each token
   //    token = strtok(NULL, " ");
   // }
   int x = fork();
   if(x==0)
   {
   		char *arg1[] = {"ls","-l", 0};
   		execvp("ls", arg1);
   }
   sleep(1);
   return 0;
}