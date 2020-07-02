#include <cstdio>
#include <iostream>


int main()
{
    int dev;
    cudaGetDeviceCount(&dev);
    std::cout<<dev<<std::endl;
    for (int i = 0; i < dev; i++) 
    {
	cudaDeviceProp prop;
	cudaGetDeviceProperties(&prop, i);
	std::cout << "device name:" << i << ": " << prop.name << std::endl;
    	std::cout << "SM的数量：" << prop.multiProcessorCount << std::endl;
    	std::cout << "每个block线程块的共享内存大小：" << prop.sharedMemPerBlock / 1024.0 << " KB" << std::endl;
    	std::cout << "每个block线程块的最大线程数：" << prop.maxThreadsPerBlock << std::endl;
    	std::cout << "每个SM的最大线程数：" << prop.maxThreadsPerMultiProcessor << std::endl;
	std::cout << "warp size:：" << prop.warpSize << std::endl;
    	std::cout << "num of warp(SP) per SM：" << prop.maxThreadsPerMultiProcessor / 32 << std::endl;
        return 0;
    }
}


