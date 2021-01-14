#include <iostream>
    #include <cuda_runtime_api.h>


int main()
    {
  int deviceCount;
  cudaDeviceProp deviceProp;

  //Сколько устройств CUDA установлено на PC.
  cudaGetDeviceCount(&deviceCount);
  std::cout << "Device count: " <<  deviceCount << "\n\n";


  for (int i = 0; i < deviceCount; i++)
      {

    //Получаем информацию об устройстве
    cudaGetDeviceProperties(&deviceProp, i);


    //Выводим иформацию об устройстве
    std::cout << "Device name: " << deviceProp.name << "\n";
    std::cout << "Total global memory: " << deviceProp.totalGlobalMem << "\n";
    std::cout << "Shared memory per block: " << deviceProp.sharedMemPerBlock << "\n";
    std::cout << "Registers per block: " << deviceProp.regsPerBlock << "\n";
    std::cout << "Warp size: " << deviceProp.warpSize << "\n";
    std::cout << "Memory pitch: " << deviceProp.memPitch << "\n";
    std::cout << "Max threads per block: " << deviceProp.maxThreadsPerBlock << "\n";
    std::cout << "Max threads dimensions: x = " << deviceProp.maxThreadsDim[0] << ", y = " << deviceProp.maxThreadsDim[1] << ", z = " << deviceProp.maxThreadsDim[2] << "\n";
    std::cout << "Max grid size: x = " << deviceProp.maxGridSize[0] << ", y = " << deviceProp.maxGridSize[1] << ", z = " << deviceProp.maxGridSize[2] << "\n";
    std::cout << "Clock rate: " << deviceProp.clockRate << "\n";
    std::cout << "Total constant memory: " << deviceProp.totalConstMem << "\n";
    std::cout << "Compute capability: " << deviceProp.major << " " << deviceProp.minor << "\n";
    std::cout << "Texture alignment: " << deviceProp.textureAlignment << "\n";
    std::cout << "Device overlap: " << deviceProp.deviceOverlap << "\n";
    std::cout << "Multiprocessor count: " << deviceProp.multiProcessorCount << "\n";
    std::cout << "Kernel execution timeout enabled: " << deviceProp.kernelExecTimeoutEnabled ? "true \n" : "false \n";
  }

  return 0;
}
