#include <cstdio>
#include <cstdlib>
#include <iostream>


__global__ void add(float* x, float * y, float* z, int n)
{
    // 获取全局索引
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    for (int i = index+5; i < n; i++)
    {		
        z[i] = x[i] + y[i];
    }
}

int main()
{
    int N = 10;
    int nBytes = N * sizeof(float);

    // 申请host内存
    // malloc 返回是void*，无法直接赋值给float型指针，于是采用(float*)强制转换
    float *x, *y, *z;
    x = (float*)malloc(nBytes);
    y = (float*)malloc(nBytes);
    z = (float*)malloc(nBytes);

    // 初始化数据
    for (int i = 0; i < N; i++)
    {
        x[i] = 1.0;
        y[i] = 2.0;
    }

    // 申请device内存
    float *d_x, *d_y, *d_z;
    cudaMalloc((void **)&d_x, nBytes);
    cudaMalloc((void **)&d_y, nBytes);
    cudaMalloc((void **)&d_z, nBytes);

    // 将host数据拷贝到device
    cudaMemcpy(d_x, x, nBytes, cudaMemcpyHostToDevice);
    cudaMemcpy(d_y, y, nBytes, cudaMemcpyHostToDevice);

    // 定义kernel的执行配置
    dim3 blockSize(4);  //一个block包含4个线程
    dim3 gridSize((N + blockSize.x - 1) / blockSize.x);  //(1048576+256-1)/256=4096

    // 执行kernel
    add  <<< gridSize, blockSize >>> (d_x, d_y, d_z, N);

    // 将device得到的结果拷贝到host
    cudaMemcpy(z, d_z, nBytes, cudaMemcpyDeviceToHost);  //d_z拷贝到z

    // 检查执行结果
    for (int i = 0; i < N; i++)
    	std::cout << z[i] << std::endl;


    // 释放device内存
    cudaFree(d_x);
    cudaFree(d_y);
    cudaFree(d_z);

    // 释放host内存
    free(x);
    free(y);
    free(z);

    return 0;
}


