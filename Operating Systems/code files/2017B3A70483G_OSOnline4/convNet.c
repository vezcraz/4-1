#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

#include "convNet.h"

void getData(FILE *inputFile, ConvNetInput *convNetInput)
{
    // Image input.
    fscanf(inputFile, "%d", &convNetInput->convImageDim);
    convNetInput->convImage = malloc(sizeof(int *) * convNetInput->convImageDim);
    for (int i = 0; i < convNetInput->convImageDim; i++)
    {
        (convNetInput->convImage)[i] = (int *) malloc(sizeof(int) * convNetInput->convImageDim);
        for (int j = 0; j < convNetInput->convImageDim; j++)
        {
            fscanf(inputFile, " %d", &convNetInput->convImage[i][j]);
        }
    }

    // Kernel Input.
    fscanf(inputFile, "%d", &convNetInput->convKernelDim);
    convNetInput->convKernel = malloc(sizeof(int *) * convNetInput->convKernelDim);
    for (int i = 0; i < convNetInput->convKernelDim; i++)
    {
        convNetInput->convKernel[i] = (int *) malloc(sizeof(int) * convNetInput->convKernelDim);
        for (int j = 0; j < convNetInput->convKernelDim; j++)
        {
            fscanf(inputFile, " %d", &convNetInput->convKernel[i][j]);
        }
    }

    fscanf(inputFile, "%d", &convNetInput->convStride);

    // Calculate the number of weights required for the fully-connected layer.
    int sqrRootWeightsNum = ((convNetInput->convImageDim) - (convNetInput->convKernelDim)) / (convNetInput->convStride) + 1;
    convNetInput->fullyConnWeightsNum = sqrRootWeightsNum * sqrRootWeightsNum;
    convNetInput->fullyConnWeights = (int *) malloc(sizeof(int) * convNetInput->fullyConnWeightsNum);
    for (int i = 0; i < convNetInput->fullyConnWeightsNum; i++)
    {
        fscanf(inputFile, " %d", &(convNetInput->fullyConnWeights)[i]);
    }

    return;
}
