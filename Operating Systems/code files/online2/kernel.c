
SYSCALL_DEFINE2(convert_float_syscall, char* str, int len)
{
	int n = len, i, pos,x, y,cnt,bitInt[32], bitFrac[100], bitRep[8], ans[32];
	int strInt, strFrac;
	int lenInt, temp, till, c, lenFrac;
	//position of the decimal point is found first
	for(i=0; i<n; i++)
		if(str[i]=='.') pos=i;
	strInt=0, strFrac=0; //to store integer and fraction part
	for(i=0; i<pos; i++)
		strInt = strInt*10+str[i]-'0'; //get the integral part

	for(i=pos+1; i<pos+9  ; i++){
		if(i<n){
			strFrac = strFrac*10+str[i]-'0';
		}
		else strFrac = strFrac*10;
	}
	x = strInt, y = strFrac;
	bitInt[32], bitFrac[100];
	cnt=0;
	while(x)
	{
		x>>=1;
		bitInt[cnt++] = x&1;
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
		if(y>=1e8) bitFrac[cnt++] = 1, y-=1e8;
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
	cnt=0;
	x = lenInt -1+127;
	bitRep[8];
	for(i=0; i<8; i++) bitRep[i]=0;

	cnt=0;
	while(x)
	{
		x>>=1;
		bitRep[cnt++] = (x&1);
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
}
// #include<stdio.h>
// #include<stdlib.h>
// #include<string.h>

// void printArray(int* arr, int n)
// {
// 	printf("%d\n",n);

// 	for(int i=0; i<n; i++) printf("%d",arr[i] );
// 	printf("\n");
// }
// void print(int x)
// {
// 	printf("%d\n", x);
// }
// void getAns(char* str, int n)
// {

// 	int pos;
// 	//position of the decimal point is found first
// 	for(int i=0; i<n; i++)
// 		if(str[i]=='.') pos=i;
// 	int strInt=0, strFrac=0; //to store integer and fraction part
// 	for(int i=0; i<pos; i++)
// 		strInt = strInt*10+str[i]-'0'; //get the integral part

// 	for(int i=pos+1; i<pos+9  ; i++){
// 		if(i<n){
// 			strFrac = strFrac*10+str[i]-'0';
// 		}
// 		else strFrac = strFrac*10;
// 	} //get the fractional part with maximum 8 places

// 	// printf("%d, %d\n",strInt, strFrac);

// 	int x = strInt, y = strFrac;
// 	int bitInt[32], bitFrac[100];

// 	//bitInt will store the value of strInt as bits
// 	int cnt=0;
// 	while(x)
// 	{
// 		int last = x&1;
// 		x>>=1;
// 		bitInt[cnt++] = last;
// 		// print(x);
// 	}
// 	int lenInt = cnt;
// 	// printArray(bitInt,lenInt);
// 	for(int i=0, j=cnt-1; j>i; i++, j--)
// 	{
// 		int temp = bitInt[i];
// 		bitInt[i] = bitInt[j];
// 		bitInt[j] = temp;
// 	}
// 	// printArray(bitInt,lenInt);
// 	// simialr thing with strFrac
// 	cnt=0;
// 	int till = 50;
// 	printf("%d\n", strFrac);
// 	while(till--)
// 	{
// 		y = 2*y;
// 		if(y>=1e8) bitFrac[cnt++] = 1, y-=1e8;
// 		else bitFrac[cnt++]=0;
// 	}
// 	int lenFrac = cnt;
// 	// printArray(bitFrac,50);


// 	int c=-1;
// 	if(lenInt==0)
// 	{
// 		c=0;
// 		while(bitFrac[c]!=1) c++, lenInt--;
// 	}
// 	int ans[32];
// 	for(int i=0; i<32; i++) ans[i]=0;
// 	cnt=0;
// 	x = lenInt -1+127;
// 	// printf("%d\n",x );
// 	// flag=0;
// 	int bitRep[8];
// 	for(int i=0; i<8; i++) bitRep[i]=0;

// 	//this block for conversion ans[1:8](inclusive) to binary 
// 	{
// 		int cnt=0;
// 		while(x)
// 		{
// 			int last = x&1;
// 			x>>=1;
// 			bitRep[cnt++] = last;
// 		}
// 		for(int i=0, j=7; j>i; i++, j--)
// 		{
// 			int temp = bitRep[i];
// 			bitRep[i] = bitRep[j];
// 			bitRep[j] = temp;
// 		}

// 	}
// 	// printArray(bitRep, 8);

// 	cnt=1;
// 	for(int i=0; i<8; i++) ans[cnt++]=bitRep[i];
// 	for(int i=1; i<lenInt; i++)
// 		ans[cnt++]=bitInt[i];
// 	for(int i=0; cnt<32; i++)
// 		ans[cnt++] = bitFrac[i+c+1];
// 	// printArray(ans,32);
// 	// return ans;
// }