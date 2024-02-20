#include <stdio.h>

// CUDA Kernel function to add the elements of two arrays on the GPU
_global_ void add(int *a, int *b, int *c) {
    *c = *a + *b;
}

int main() {
    // define host variables
    int a, b, c;
    // define device variables
    int *d_a, *d_b, *d_c;
    int size = sizeof(int);

    // Allocate space for device variables
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    // Setup input values  
    a = 2;
    b = 7;

    // Copy inputs to device
    cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);

    // Launch add() kernel on GPU
    add<<<1,1>>>(d_a, d_b, d_c);

    // Copy result back to host
    cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);

    // Cleanup
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    
    printf("The sum is %d\n",c);

    return 0;
}
