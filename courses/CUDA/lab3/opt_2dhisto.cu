#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include <cutil.h>
#include "util.h"
#include "ref_2dhisto.h"
#include "opt_2dhisto.h"
__global__ void opt_histo_kernel(uint32_t *input, uint8_t *resultopt, int width, int height);


void opt_2dhisto(int numBlocksW, int numBlocksH, int blockWidth, int blockHeight, uint32_t *inputd, uint8_t *resultd)
{
    /* This function should only contain a call to the GPU 
       histogramming kernel. Any memory allocations and
       transfers must be done outside this function */
	
	dim3 dimGrid(numBlocksW,numBlocksH);
	dim3 dimBlock(blockWidth, blockHeight);

	opt_histo_kernel<<<dimGrid, dimBlock>>>(inputd, resultd, INPUT_WIDTH, INPUT_HEIGHT);
	
}

uint32_t *AllocateDeviceMemData(){
	int size = INPUT_HEIGHT * INPUT_WIDTH * sizeof(uint32_t); 
	uint32_t *array_device ;
	cudaMalloc((void**)&array_device, size);
	return array_device;
}

uint8_t *AllocateDeviceMemResult(){
	int size = HISTO_HEIGHT * HISTO_WIDTH * sizeof(uint8_t);
	uint8_t *array_device;
	cudaMalloc((void**)&array_device, size);
	return array_device;
}

void CopyToDevice(uint32_t *dataDevice, uint32_t **dataHost, uint8_t *resultDevice, uint8_t *resultHost){
	
	int result_size = HISTO_HEIGHT * HISTO_WIDTH * sizeof(uint8_t);
	int data_size = INPUT_HEIGHT * INPUT_WIDTH * sizeof(uint32_t);
	for(int i=0; i < INPUT_HEIGHT; i++){
		cudaMemcpy(dataDevice + i*INPUT_WIDTH, dataHost[i], data_size, cudaMemcpyHostToDevice);
	}
	cudaMemcpy(resultDevice, resultHost, result_size, cudaMemcpyHostToDevice);

	
}

void CopyFromDevice(uint8_t *arrHost, uint8_t *arrDevice){
	
	int size = HISTO_WIDTH*HISTO_HEIGHT * sizeof(uint8_t);
	cudaMemcpy(arrHost, arrDevice, size, cudaMemcpyDeviceToHost);

}

void FreeCudaMemData(uint32_t *array){

	cudaFree(array);
}

void FreeCudaMemResult(uint8_t *array){

	cudaFree(array);
}

/* Include below the implementation of any other functions you need */
__global__ void opt_histo_kernel(uint32_t *input, uint8_t *resultopt, int width, int height){

	// This is an attempt of the block method: each threadblock calculates a sub-histogram in shared memory.

	// Step 1: Initialize partial histogram
	// Each thread:

	// Make thread & block IDs simple	
	int bx = blockIdx.x;
	int by = blockIdx.y;
	int tx = threadIdx.x;
	int ty = threadIdx.y;

	// Find location of input element using rows and cols
	int row = by*blockDim.y + ty;
	int col = bx*blockDim.x + tx;

	// Value for each bin in sub-histogram
	float value = 0.0;

	if ((row < height) && (col < width)){
		value = input[row * width + col];
	//	resultopt[value]++;
	}

}
