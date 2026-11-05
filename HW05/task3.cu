#include <cuda.h>
#include "vscale.cuh"
#include <stdio.h>
#include <chrono>
#include <random>

// Vscale kernel
__global__ void vscale(const float *a, float *b, unsigned int n) {

	int index = 512*blockIdx.x+threadIdx.x;

	// Make sure threads and blocks are in actual array
	if (index < n) {
		b[index] *= a[index];
	}
}


// This function will take a and b and multiply them element wise
int main(int argc, char* argv[]) {
	
	// Number of elements in each array is only input
	int n = std::atoi(argv[1]);

	// Generate random numbers for a and b
	std::random_device seed;
	std::mt19937 gen(seed());
	std::uniform_real_distribution<float> distA(-10.0, 10.0);
	std::uniform_real_distribution<float> distB(0.0, 1.0);

	// Populate arrays
	float* a = new float[n];
	float* b = new float[n];
	float* da, *db;
	
	for (int i = 0; i < n; i++) {
		a[i] = distA(gen);
		b[i] = distB(gen);
	}
	
	// Initialize cuda arrays
	cudaMalloc((void**)&da, sizeof(float)*n);
	cudaMalloc((void**)&db, sizeof(float)*n);
	
	// Copy memory to GPU
	cudaMemcpy(da, a, sizeof(float)*n, cudaMemcpyHostToDevice);
	cudaMemcpy(db, b, sizeof(float)*n, cudaMemcpyHostToDevice);
	
	// Initialize kernel
	int numThreads = 512;
	int numBlocks = ((n-1)/numThreads+1);

	using std::chrono::high_resolution_clock;
	using std::chrono::duration;

	high_resolution_clock::time_point start;
	high_resolution_clock::time_point end;
	duration<double, std::milli> dur;


	// Run the kernel
	start = high_resolution_clock::now();
	vscale<<<numBlocks, numThreads>>>(da,db,n);
	cudaDeviceSynchronize();
	end = high_resolution_clock::now();

	dur = end - start;

	// Bring back the device b array to the CPU
	cudaMemcpy(b, db, sizeof(float)*n, cudaMemcpyDeviceToHost);
	
	// Print time of process, first element, last element
	printf("%f\n%f\n%f\n", dur.count(), b[0], b[n-1]);
	return 0;
}


