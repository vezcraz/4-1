#include<pthread.h> 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
char str1[100];
char str2[100];
char temp[100];
int res[100];
int n;
void print(int x)
{
    printf("%d \n", x);
}
void* runner(void* arg){
    int* lol = (int *)arg;
    int p1 = lol[1];
    int p2 = lol[0];
    int sum = 0;
    int x = p1, y=p2;
    while(p1<=y){

        sum+=(str1[p1++]-'0')*(str2[p2--]-'0');
    }
    printf("%d %d %d\n",x,y,sum);
    res[lol[2]] = sum;
    pthread_exit(0);
}

int main(int argc, char* argv[]){
    memset(res, 0, sizeof(res));
    int n1 = strlen(argv[1]);
    int n2 = strlen(argv[2]);
    int diff;
    if(n1>=n2){
        n=n1;
        diff = n1-n2;
        strcpy(str1, argv[1]);
        strcpy(temp, argv[2]);
    }
    else
    {
        n=n2;
        diff = n2-n1;
        strcpy(temp, argv[1]);
        strcpy(str1, argv[2]);
    }
    for(int i=0; i<diff; i++)
        str2[i] = '0';
    int c=0;
    for(int i=diff; i<n; i++)
        str2[i]=temp[c++];
    int idx = 0;
    printf("%s\n",str2 );
    int total_threads = n1+n2-1;
    pthread_t tid_arr[total_threads];
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    int arr[n+n-1][3];
    int p1 = 0;
    int p2 = 0;
    for(int i=0; i<2*n-1; i++){
        if(p1 < n){
            arr[i][0] = p1++;
            arr[i][1] = p2;
            arr[i][2] = i;
        }
        else{
            arr[i][0] = p1-1;
            arr[i][1] = ++p2;
            arr[i][2] = i;
        }
        printf("%d %d \n",arr[i][0],arr[i][1]);
    }
    int count=0;
    for(int i=2*n-2; count<total_threads;i--){
        // print(i);
        pthread_create(&tid_arr[count], &attr, runner, arr[i]);
        count++;
    }
    for(int i=0; i<total_threads; i++){
        pthread_join(tid_arr[i], NULL);
    }
    for(int i=0; i<2*n-1; i++){
        printf("%d ", res[i]);
    }


}