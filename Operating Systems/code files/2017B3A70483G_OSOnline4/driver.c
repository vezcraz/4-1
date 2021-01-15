#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

#include "convNet.h"

typedef struct box //pass this to calculate clout
{
    ConvNetInput *cn;
    int x,y; //the top left corner for getting the startpoint
    int clOut[1000][1000];
} box;
void* multiply(void* arg)
{
	box* f = (box*)arg;
	int ans=0;
	int kerDim = f->cn->convKernelDim;
	if(f->x==3) f->x=0;
	for(int i=f->x, ik=0; i<f->x+kerDim; i++,ik++)
	{
		for(int j=f->y,jk=0; j<f->y+kerDim; j++,jk++)
		{
			ans+= f->cn->convImage[i][j] * f->cn->convKernel[ik][jk]; 
		}
	}
	int *res = (int *)malloc(sizeof(int));
    *res = ans;
    pthread_exit(res);
}
void* outPrint(void* x)
{
	ConvNetInput* cn =(ConvNetInput*)x; 
	printf("convImageDim: %d\n",cn->convImageDim );
	int imDim = cn->convImageDim;
	printf("Image Input:\n" );
	for(int i=0; i<imDim; i++)
	{
		for(int j=0; j<imDim; j++)
			printf("%d ",cn->convImage[i][j] );
		printf("\n" );
	}
	int kerDim = cn->convKernelDim;
	printf("\nconvKernelDim: %d\n",kerDim);

	for(int i=0; i<kerDim; i++)
	{
		for(int j=0; j<kerDim; j++)
			printf("%d ",cn->convKernel[i][j] );
		printf("\n" );
	}
	printf("\nconvStride: %d\n\n", cn->convStride);
	printf("fullyConnWeightsNum: %d\n",cn->fullyConnWeightsNum);
	printf("fullyConnWeights: \n");

    for(int i=0; i<cn->fullyConnWeightsNum; i++){
        printf("%d ", cn->fullyConnWeights[i]);
    }
	pthread_exit(NULL);
}
void* printCl(void* arg){
    
    printf("\n");
    box* f = (box*)arg;
    printf("Output Matrix:\n");
    for(int i=0; i<f->cn->convKernelDim; i++){
        for(int j=0; j<f->cn->convKernelDim; j++){
            printf("%d ", f->clOut[i][j]);
        }
        printf("\n");
    }
    pthread_exit(NULL);
    
}
int convNet(char* filename)
{
	ConvNetInput *cn=(ConvNetInput*)malloc(sizeof(ConvNetInput));
	FILE* file = fopen("input.txt", "r");
	getData(file,cn);
	pthread_t tid;
	pthread_attr_t attr;
	pthread_attr_init(&attr);
	pthread_create(&tid,&attr,outPrint,cn);	
	pthread_join(tid,NULL);
	fclose(file);
	int nOut = 1+(cn->convImageDim-cn->convKernelDim)/cn->convStride;
	int **clOut = (int**)malloc(nOut*sizeof(int*));
	for(int i=0; i<nOut; i++)
	{
		clOut[i] = (int*)malloc(nOut*sizeof(int));
	}

//threads for clOut
	pthread_t tid_cl[nOut][nOut];
	box* f=(box*)malloc(sizeof(box));;
	f->cn = cn;
	f->x=0,f->y=0;

	for(int i=0; i<nOut; i++)
	{
		for(int j=0; j<nOut; j++)
		{
			pthread_create(&tid_cl[i][j],&attr, multiply,(void*)f);
			f->y = f->y + f->cn->convStride;
		}
		f->x = f->x + f->cn->convStride;
		f->y=0;
	}
	for(int i=0; i<nOut; i++)
	{
		for(int j=0; j<nOut; j++){
			void *val;
			pthread_join(tid_cl[i][j],&val);
			clOut[i][j]=*((int*)val);
			// printf("%d\n",clOut[i][j] );
		}
	}
//printing
	for(int i=0; i<nOut; i++)
	{
		for(int j=0; j<nOut; j++)
		{
			f->clOut[i][j]=clOut[i][j];
		}
	}
	pthread_t tid_clPrint;
	pthread_create(&tid_clPrint,&attr,printCl,f );
	pthread_join(tid_clPrint,NULL);
	return 0;
}
int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Please enter the right number of command-line arguments.\n");
        exit(0);
    }

    int finalValue = convNet(argv[1]);
    printf("The value retured by the convNet function is = %d\n", finalValue);

    return 0;
}