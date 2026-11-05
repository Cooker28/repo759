#include <cuda.h>
#include <stdio.h>


// This cuda file computes the factorial of integers from 1 to 8
// It does this by using a GPU kernal with 1 block and 8 threads


// Simple kernal for printing required output
__global__ void factorialKernel() {
	
	// Assign variables to start factorial (each thread gets 1)
	int a = threadIdx.x;
	int b = 1;
	
	// Run factorial function
	for (int i = (a+1); i > 0; i--) {
		b *= i;
	}

	// Print a!=b
	printf("%d!=%d\n", a+1, b);
}

int main(){
	
	// Initialize number of threads
	const int numThreads = 8;
	
	// Put the threads in the kernal to run
	factorialKernel<<<1, numThreads>>>();
	cudaDeviceSynchronize();
	return 0;
}
