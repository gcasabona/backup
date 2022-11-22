#ifndef _PRESCAN_CU_
#define _PRESCAN_CU_

// includes, kernels
#include <assert.h>


#define NUM_BANKS 32
#define LOG_NUM_BANKS 5
// Lab4: You can use any other block size you wish.

#define BLOCK_SIZE 256

//#define NUM_BANKS 16
//#define LOG_NUM_BANKS 4 
//#ifdef ZERO_BANK_CONFLICTS
//#define CONFLICT_FREE_OFFSET(n) \
 ((n) >> NUM_BANKS + (n) >> (2 * LOG_NUM_BANKS))
//#else
//#define CONFLICT_FREE_OFFSET(n) ((n) >> LOG_NUM_BANKS)
//#endif
// Lab4: Host Helper Functions (allocate your own data structure...)

#endif

__global__ void scan(float *g_odata, float *g_idata, const int n);
void prescanArray(float *outArray, float *inArray, int numElements, float *sum);
__device__ void summation(float *sum);


// Lab4: Device Functions
__device__ void summation(float *sum){

	// This function should calculate the parallel prefix scan for the sum array
	//Now scan sum array

        int id = 0;
        int offsetSum = 1;
        for (int id = 0; id < gridDim.x; id++){ 
                for (int d = gridDim.x>>1; d > 0; d >>= 1) // build sum in place up the tree
                {
//                      __syncthreads();
                        if (id < d)
                        {
                                int a = offsetSum*(2*id+1)-1;
                                int b = offsetSum*(2*id+2)-1;
        
                                sum[b] += sum[a];
                        }
                offsetSum *= 2;
                }
        }
        sum[gridDim.x-1] = 0;
        
        for (int id = 0; id < gridDim.x; id++){
                for (int d = 1; d < gridDim.x; d *= 2) // traverse down tree & build scan
                {
                        offsetSum >>= 1;
                        __syncthreads();
                         if (id < d)
                        {
                                int a = offsetSum*(2*id+1)-1;
                                int b = offsetSum*(2*id+2)-1;
                                float t = sum[a];
                                sum[a] = sum[b];
                                sum[b] += t;
                        }
                }

        }
        
		


}

// Lab4: Kernel Functions
// n: block size. one thread can handle two elements
__global__ void scan(float *g_odata, float *g_idata, const int n, float *sum)
{

 	extern __shared__ float temp[]; // allocated on invocation: only needs to be as big as num threads in block

	int thid = threadIdx.x;	//thread id in block
	int gid = blockIdx.x*blockDim.x + thid;	//global id
	
	int offset = 1;
	
	//int numBlocks = dimGrid.x;

//	float sum[numBlocks];

	//Every thread handles two elements
	//temp[2*thid] = g_idata[2*gid]; // load input into shared memory
        //temp[2*thid+1] = g_idata[2*gid+1];

	
	temp[2*thid] = g_idata[2*thid]; // load input into shared memory
	temp[2*thid+1] = g_idata[2*thid+1];
	
/*
	int ai = thid;
	int bi = thid + (n/2);
	int bankOffsetA = CONFLICT_FREE_OFFSET(ai);
	int bankOffsetB = CONFLICT_FREE_OFFSET(ai);
	temp[ai + bankOffsetA] = g_idata[ai];
	temp[bi + bankOffsetB] = g_idata[bi]; 
*/

	// load input into shared memory.
 	// This is exclusive scan, so shift right by one and set first element to 0

	for (int d = n>>1; d > 0; d >>= 1) // build sum in place up the tree
 	{
 		__syncthreads();
 		if (thid < d)
 		{
 			int ai = offset*(2*thid+1)-1;
			int bi = offset*(2*thid+2)-1;
//			ai += CONFLICT_FREE_OFFSET(ai);
//			bi += CONFLICT_FREE_OFFSET(bi); 

			temp[bi] += temp[ai];
 		}
 		offset *= 2;
 	}
	

	// fill sum array with the sum of the first array
	__syncthreads();
	// Now we have the sum array. This needs to be added back to the blocks
	//temp[thid] += sum[blockIdx.x]; 		
	
	//if (thid==0) { temp[n – 1 + CONFLICT_FREE_OFFSET(n - 1)] = 0; }	
 	if (thid == 0) { temp[n - 1] = 0; } // clear the last element
 	


	for (int d = 1; d < n; d *= 2) // traverse down tree & build scan
        {
                offset >>= 1;
                __syncthreads();
                 if (thid < d)
                {
                        int ai = offset*(2*thid+1)-1;
                        int bi = offset*(2*thid+2)-1;
       
//			ai += CONFLICT_FREE_OFFSET(ai);
//			bi += CONFLICT_FREE_OFFSET(bi); 

	                 float t = temp[ai];
                        temp[ai] = temp[bi];
                        temp[bi] += t;
                }
        }

	//__syncthreads();
//	temp[thid] += sum[blockIdx.x];
	
 	__syncthreads();
 //	g_odata[2*gid] = temp[2*thid]; // write results to device memory
 //	g_odata[2*gid+1] = temp[2*thid+1];
	//g_odata[ai] = temp[ai + bankOffsetA];
	//g_odata[bi] = temp[bi + bankOffsetB]; 						
 	g_odata[2*thid] = temp[2*thid]; // write results to device memory
 	g_odata[2*thid+1] = temp[2*thid+1];
}


	
	

// **===-------- Lab4: Modify the body of this function -----------===**
// You may need to make multiple kernel calls, make your own kernel
// function in this file, and then call them from here.
void prescanArray(float *outArray, float *inArray, int numElements)
{
	// Divide input array into blocks
	// Remember that each thread can handle two elements
	// BLOCK_SIZE is set above as a constant
	const int numBlocks = ceil(numElements/BLOCK_SIZE);

	float *sum;
	float *inc;
	
	// Allocate global device memory for arrays to communicate sum data
	cudaMalloc((void**)&sum, numBlocks*sizeof(float));
	cudaMalloc((void**)&inc, numBlocks*sizeof(float));

	
	dim3 dimGrid(1);
	dim3 dimBlock(numElements);
    	//scan<<<dimGrid, dimBlock, 2*sizeof(float)*numElements+1>>>(outarray, inArray, numElements);
	scan<<<dimGrid, dimBlock, 2*sizeof(float)*numElements+1>>>(outArray, inArray, numElements, sum); 
	
//	cudaThreadSynchronize();

	//summation<<< >>>();
//	cudaThreadSynchronize();    
}
// **===-----------------------------------------------------------===**

