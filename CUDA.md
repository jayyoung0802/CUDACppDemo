- CUDA计算平台、通用编程模型
- 

	1. 运行在CPU上，利用GPU完成复杂的计算任务。
	2. grid,block在软件层面，多线程需要多核的硬件去实现，CUDA多核心
	3. GPU里包含大量的流线多处理器SM(Stream Multiprocessor)，即CUDA Core，
	4. SM包含大量流处理器(SP)
	5. SP中可使用的线程个数为线程束“warp size”
	6. SM中最大线程数=SM中SP的个数*warp size
	7. kernel是在device上线程中并行执行的函数
	8. 一个kernel所启动的所有线程称为grid
	9. grid可以分为很多线程块block
	10. block里即线程个数




- CUDA程序执行流程
- 

	1. 分配host内存，并进行数据初始化；
	2. 分配device内存，并从host将数据拷贝到device上；
	3. 调用CUDA的核函数在device上完成指定的运算；
	4. 将device上的运算结果拷贝到host上；
	5. 释放device和host上分配的内存。