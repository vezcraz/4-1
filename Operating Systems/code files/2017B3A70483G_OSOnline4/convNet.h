#ifndef CONVNET_H
#define CONVNET_H

typedef struct ConvNetInput
{
    int convImageDim;
    int convKernelDim;
    int **convImage;
    int **convKernel;
    int convStride;
    int fullyConnWeightsNum;
    int *fullyConnWeights;
} ConvNetInput;

/*
	Add all the structures required for the program here
*/

int convNet(char *fileName);
void getData(FILE *inputFile, ConvNetInput *ConvNetInput);

/* 
	Add declarations of all the required functions here
*/


#endif