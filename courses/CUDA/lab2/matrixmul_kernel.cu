/*
 * Copyright 1993-2006 NVIDIA Corporation.  All rights reserved.
 *
 * NOTICE TO USER:   
 *
 * This source code is subject to NVIDIA ownership rights under U.S. and 
 * international Copyright laws.  
 *
 * This software and the information contained herein is PROPRIETARY and 
 * CONFIDENTIAL to NVIDIA and is being provided under the terms and 
 * conditions of a Non-Disclosure Agreement.  Any reproduction or 
 * disclosure to any third party without the express written consent of 
 * NVIDIA is prohibited.     
 *
 * NVIDIA MAKES NO REPRESENTATION ABOUT THE SUITABILITY OF THIS SOURCE 
 * CODE FOR ANY PURPOSE.  IT IS PROVIDED "AS IS" WITHOUT EXPRESS OR 
 * IMPLIED WARRANTY OF ANY KIND.  NVIDIA DISCLAIMS ALL WARRANTIES WITH 
 * REGARD TO THIS SOURCE CODE, INCLUDING ALL IMPLIED WARRANTIES OF 
 * MERCHANTABILITY, NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE.   
 * IN NO EVENT SHALL NVIDIA BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL, 
 * OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS 
 * OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE 
 * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE 
 * OR PERFORMANCE OF THIS SOURCE CODE.  
 *
 * U.S. Government End Users.  This source code is a "commercial item" as 
 * that term is defined at 48 C.F.R. 2.101 (OCT 1995), consisting  of 
 * "commercial computer software" and "commercial computer software 
 * documentation" as such terms are used in 48 C.F.R. 12.212 (SEPT 1995) 
 * and is provided to the U.S. Government only as a commercial end item.  
 * Consistent with 48 C.F.R.12.212 and 48 C.F.R. 227.7202-1 through 
 * 227.7202-4 (JUNE 1995), all U.S. Government End Users acquire the 
 * source code with only those rights set forth herein.
 */

/* Matrix multiplication: C = A * B.
 * Device code.
 */

#ifndef _MATRIXMUL_KERNEL_H_
#define _MATRIXMUL_KERNEL_H_

#include <stdio.h>
#include "matrixmul.h"

////////////////////////////////////////////////////////////////////////////////
//! Simple test kernel for device functionality
//! @param g_idata  input data in global memory
//! @param g_odata  output data in global memory
////////////////////////////////////////////////////////////////////////////////
// Matrix multiplication kernel thread specification
__global__ void MatrixMulKernel(Matrix M, Matrix N, Matrix P)
{
	const int tileWidth = 32;
	
	__shared__ float Msh[tileWidth][tileWidth];	
	__shared__ float Nsh[tileWidth][tileWidth];
	
	int bx = blockIdx.x;
	int by = blockIdx.y;
	int tx = threadIdx.x;
	int ty = threadIdx.y;
	
	// Calculate the row index of the Pd element and M
	int Row = by*blockDim.y + ty; // yIndex
	
	// Calculate the column index of Pd and N
	int Col = bx*blockDim.x + tx; // xIndex
	
//	float Pvalue = 0;
	float Ppartial = 0;

        //printf("M.width = %d \n", M.width);
	// Read the input through shared memory: the point is to do the calculation in shared memory and write output to global memory. This is for COALESING.
	// To avoid bank conflicts, add PADDING
//	if (Row < P.height && Col < P.width){
		
		// Loop over tiles along M width and N height, which are the same
		int numTiles =  M.width/tileWidth;
		if ((M.width % tileWidth)>0){ numTiles++;   }
                 
		int overflow = (numTiles*tileWidth) - M.width;

		for (int m=0; m<numTiles; m++){

//		//FOR uncoalesced only! 
//		for (int k=0; k<M.width; k++) {
//			float Mel = M.elements[Row*M.width + k];
//              	float Nel = N.elements[k*N.width + Col];
//             		Pvalue += Mel * Nel;
//		}
		
//			Ppartial = 0;
			
//			Msh[ty][tx] = M.elements[Row*M.width + m*tileWidth + tx];
//			Nsh[ty][tx] = N.elements[(m*tileWidth + ty)*N.width + Col];
		 
//			__syncthreads();		
	
			
			if ((Row > M.height-1) || (m*tileWidth + tx > M.width-1)){
	 			Msh[ty][tx] = 0;
			}
			else {
				
			Msh[ty][tx] = M.elements[Row*M.width + m*tileWidth + tx];
			}
			if ((Col > N.width-1) || (m*tileWidth + ty > N.height-1)){
				Nsh[ty][tx] = 0;
			}
else {
			Nsh[ty][tx] = N.elements[(m*tileWidth + ty)*N.width + Col];
}
		 	//if (m == (numTiles - 1 )){
                        //	if (( tx  > (tileWidth - overflow) - 1 )|| (ty > (tileWidth - overflow) -1)){
                         //  		Msh[ty][tx] = 0;
                          //		Nsh[ty][tx] = 0;
			//	}
			//}
		        __syncthreads();
			
			for (int p=0; p<tileWidth; ++p){
				Ppartial += Msh[ty][p] * Nsh[p][tx];
                        //                         Pvalue += Ppartial;
			//	__syncthreads();

			}
                
                        __syncthreads();
        //		Pvalue += Ppartial;
		}
		//Pvalue += Ppartial;
//	}
	//__syncthreads();

	
	if (Row < P.height && Col < P.width){
		P.elements[Row * P.width + Col] = Ppartial;
	}
	
}

#endif // #ifndef _MATRIXMUL_KERNEL_H_
