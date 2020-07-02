#include <cstdio>
#include <cstdlib>
#include <iostream>

#include <iostream>
#include <stdlib.h>
#include <sys/time.h>

#define ROWS 2
#define COLS 2

using namespace std;

__global__ void matrix_mul_gpu(float* M, float* N, float* P, int width)
{
    for(int i=0;i<width;i++)
        for(int j=0;j<width;j++)
        {
            float sum = 0.0;
            for(int k=0;k<width;k++)
            {
                float a = M[i*width+k];
                float b = N[k*width+j];
                sum += a*b;
            }
            P[i*width+j] = sum;
        }
}

int main()
{
    struct timeval start, end;
    gettimeofday( &start, NULL );
    float *A, *B, *C;
    int total_size = ROWS*COLS*sizeof(float);
    A = (float*)malloc(total_size);
    B = (float*)malloc(total_size);
    C = (float*)malloc(total_size);

    //CPU一维数组初始化
    for(int i=0;i<ROWS*COLS;i++)
    {
        A[i] = 2.0;
        B[i] = 1.0;
    }

    float *d_A, *d_B, *d_C;
    cudaMalloc((void **)&d_A, total_size);
    cudaMalloc((void **)&d_B, total_size);
    cudaMalloc((void **)&d_C, total_size);

    cudaMemcpy(d_A, A, total_size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, total_size, cudaMemcpyHostToDevice);


    dim3 blockSize(4);  //一个block包含4个线程
    dim3 gridSize((4 + blockSize.x - 1) / blockSize.x);  //(1048576+256-1)/256=4096

    // 执行kernel
    matrix_mul_gpu<<<gridSize, blockSize>>>(d_A,d_B,d_C,COLS);

        // 将device得到的结果拷贝到host
    cudaMemcpy(C, d_C, total_size, cudaMemcpyDeviceToHost);  //d_z拷贝到z

    // 检查执行结果
    for (int i = 0; i < COLS; i++)
    {
        for (int j=0;j<COLS;j++)
            std::cout << C[i*COLS+j] << std::endl;
    }
    	
    // 释放device内存
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);

    // 释放host内存
    free(A);
    free(B);
    free(C);

    gettimeofday( &end, NULL );
    int timeuse = 1000000 * ( end.tv_sec - start.tv_sec ) + end.tv_usec - start.tv_usec;
    cout << "total time is " << timeuse/1000 << "ms" <<endl;

    return 0;
}


