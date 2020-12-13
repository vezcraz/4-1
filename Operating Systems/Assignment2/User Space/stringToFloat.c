    #include <unistd.h>
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include <math.h>
    #include "stringToFloat.h"
    #define MY_SYSCALL 440
     
    float getFloat(char str[], int n){
        int flag=1, dot=0, pos=-1;
        for(int i=0; i<n; i++){
            if(str[i]=='.') pos=i, dot++;
            else if(str[i]=='-' && i==0) continue; 
            else if(str[i]<'0' || str[i]>'9') flag=0;
          }

        if((pos==-1 || !flag || dot>1))
        {
            printf("String in not valid.\n");
            return 100001.0;
        }
        long result =fts_syscall(str,n);
        float *ans;
        ans = (float*)(&result);
        return *ans;
    }
    // int main()
    // {
    //     return 0;
    // }
