#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/syscalls.h>
#include <linux/uaccess.h>
#include "fts_syscall.h"

SYSCALL_DEFINE2(fts_syscall, char *, arr, int, len)
{
  
  int n = len;
  int i,j, pos=-1,cnt,bitInt[32], bitFrac[100], bitRep[8], ans[32];
  long long int strInt, strFrac;
  long long int x, y;
  int lenInt, temp, till, c, lenFrac;
  int code=0, sign=0, dot=0 ;
  int final=0, flag=0;
 
///--------------------------------------
  char* str[500];
  if(copy_from_user(str, arr, n)){
        return 1203982464; //IEEE form
  }
///---------------------------------------
  if(str[0]=='-') sign=1;

  strInt=0, strFrac=0;
  for(i=0; i<n; i++){
    if(str[i]=='.') pos=i;
  }

  for(i=0; i<pos; i++){
    if(str[i]=='-') continue;
    else
      strInt = strInt*10+str[i]-'0'; 
  }
 
  for(i=pos+1; i<pos+15  ; i++){
    if(i<n){
      strFrac = strFrac*10+str[i]-'0';
    }
    else strFrac = strFrac*10;
  }
  if((strInt>1e5 || (strInt==1e5 && strFrac>0)) && code==0 && sign==0) //number greater than lac
	return 1203982592;
  if((strInt>1e5 || (strInt==1e5 && strFrac>0)) && code==0 && sign==1) //number less than -lac
	return 1203982848;
  if(strInt==0 && strFrac*100<=1e14 && code==0) // |no.|<=0.01
	return 1203982720;
 
 
  x = strInt, y = strFrac;
  bitInt[32], bitFrac[100];
  cnt=0;
  while(x)
  {
    bitInt[cnt++] = (x&1);
    x>>=1;
  }
  lenInt = cnt;
  for(i=0, j=cnt-1; j>i; i++, j--)
  {
    temp = bitInt[i];
    bitInt[i] = bitInt[j];
    bitInt[j] = temp;
  }
  cnt=0;
  till = 50;
  while(till--)
  {
    y = 2*y;
    if(y>=1e14) bitFrac[cnt++] = 1, y-=1e14;
    else bitFrac[cnt++]=0;
  }
  lenFrac = cnt;
  c=-1;
  if(lenInt==0)
  {
    c=0;
    while(bitFrac[c]!=1) c++, lenInt--;
  }
  ans[32];
  for(i=0; i<32; i++) ans[i]=0;
  ans[0]=sign;
  cnt=0;
  x = lenInt -1+127;
  bitRep[8];
  for(i=0; i<8; i++) bitRep[i]=0;
 
  cnt=0;
  while(x)
  {
    bitRep[cnt++] = (x&1);
    x>>=1;
  }
  for(i=0, j=7; j>i; i++, j--)
  {
    temp = bitRep[i];
    bitRep[i] = bitRep[j];
    bitRep[j] = temp;
  }
 
  cnt=1;
  for(i=0; i<8; i++) ans[cnt++]=bitRep[i];
  for(i=1; i<lenInt; i++)
    ans[cnt++]=bitInt[i];
  for(i=0; cnt<32; i++)
    ans[cnt++] = bitFrac[i+c+1];
	
	final=0;
	for(i=0; i<32; i++)
	{
		final<<=1;
		final= final|ans[i];
	}
	return final;
	
}