#include <cuda.h>
#include <iostream>
#include <random>

// Kernel for printing ax+b
__global__ void axyKernel(int* data, int a) {
	
	data[8*blockIdx.x+threadIdx.x] = a*threadIdx.x + blockIdx.x;
}

// This will compute ax+y where x is the threadsIdx and y is the blockIdx
int main() {

	// Generate random number as scalar
	std::random_device seed;
	std::mt19937 gen(seed());
	std::uniform_int_distribution<int> dist(1, 10);
	
	// Assign a to random number between 1 and 10
	int a = dist(gen);

	// Allocate an arry of 16 ints
	const int numInts = 16;
	int hA[numInts], *dA;

	// Allocate memory on the GPU
	cudaMalloc((void**)&dA, sizeof(int)*numInts);
	cudaMemset(dA, 0, numInts*sizeof(int));

	// Create kernel
	int numBlocks = 2;
	int numThreads = 8;
	axyKernel<<<numBlocks, numThreads>>>(dA, a);
	cudaDeviceSynchronize();

	// Bring back memory from the GPU
	cudaMemcpy(&hA, dA, sizeof(int)*numInts, cudaMemcpyDeviceToHost);

	// Print out host array
	for (int i = 0; i < numInts; i++) {
		printf("%d ", hA[i]);
	}
	printf("\n");
	return 0;
}
