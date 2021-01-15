#include "randomizer.h"
#include "flow.h"
#include "worker.h"
#include "generator.h"




double randomizerGpu (unsigned *vec, unsigned length, unsigned min, unsigned max) {


  double middleValue = 0.0;


  unsigned *minGpu;
  unsigned *maxGpu;
  unsigned *vecGpu;
  unsigned *lengthGpu;
  unsigned countFlow = getCountFlow();
  unsigned *countFlowGpu;
  unsigned countBlock = getCountBlock();


  unsigned *poolA = createPoolA(countFlow);
  unsigned *poolB = createPoolB(poolA, countFlow);
  unsigned *poolX = createPoolX(poolA, countFlow);


  unsigned *poolAGpu;
  unsigned *poolBGpu;
  unsigned *poolXGpu;


  double *poolMiddleValue = new double[countFlow];
  double *poolMiddleValueGpu;


  unsigned lastA = getLastA(poolA, countFlow);
  unsigned *lastAGpu;


  cudaMalloc((void **)&vecGpu, length * sizeof(unsigned));
  cudaMalloc((void **) &poolAGpu, countFlow * sizeof(unsigned));
  cudaMalloc((void **) &poolBGpu, countFlow * sizeof(unsigned));
  cudaMalloc((void **) &poolXGpu, countFlow * sizeof(unsigned));
  cudaMalloc((void **) &poolMiddleValueGpu, countFlow * sizeof(double));
  cudaMalloc((void **) &countFlowGpu, sizeof(unsigned));
  cudaMalloc((void **) &lengthGpu, sizeof(unsigned));
  cudaMalloc((void **) &minGpu, sizeof(unsigned));
  cudaMalloc((void **) &maxGpu, sizeof(unsigned));
  cudaMalloc((void **) &lastAGpu, sizeof(unsigned));


  //cudaMemcpy(vecGpu, vec, length * sizeof(unsigned), cudaMemcpyHostToDevice);
  cudaMemcpy(poolAGpu, poolA, countFlow * sizeof(unsigned), cudaMemcpyHostToDevice);
  cudaMemcpy(poolBGpu, poolB, countFlow * sizeof(unsigned), cudaMemcpyHostToDevice);
  cudaMemcpy(poolXGpu, poolX, countFlow * sizeof(unsigned), cudaMemcpyHostToDevice);
  cudaMemcpy(poolMiddleValueGpu, poolMiddleValue, countFlow * sizeof(double), cudaMemcpyHostToDevice);
  cudaMemcpy(lengthGpu, &length, sizeof(unsigned), cudaMemcpyHostToDevice);
  cudaMemcpy(countFlowGpu, &countFlow, sizeof(unsigned), cudaMemcpyHostToDevice);
  cudaMemcpy(minGpu, &min, sizeof(unsigned), cudaMemcpyHostToDevice);
  cudaMemcpy(maxGpu, &max, sizeof(unsigned), cudaMemcpyHostToDevice);
  cudaMemcpy(lastAGpu, &lastA, sizeof(unsigned), cudaMemcpyHostToDevice);


  worker<<<countBlock, countFlow>>>(vecGpu, poolBGpu, poolXGpu, countFlowGpu, lengthGpu, poolMiddleValueGpu, minGpu, maxGpu, lastAGpu);


  cudaMemcpy(poolMiddleValue, poolMiddleValueGpu, countFlow * sizeof(double), cudaMemcpyDeviceToHost);
  cudaMemcpy(vec, vecGpu, length * sizeof(unsigned), cudaMemcpyDeviceToHost);


  for(unsigned i = 0; i < countFlow; i++) {
    middleValue += poolMiddleValue[i];
  }


  middleValue = middleValue / length;

  delete [] poolA;
  delete [] poolX;
  delete [] poolMiddleValue;
  cudaFree(vecGpu);
  cudaFree(poolAGpu);
  cudaFree(poolXGpu);
  cudaFree(poolMiddleValueGpu);
  cudaFree(lengthGpu);
  cudaFree(minGpu);
  cudaFree(maxGpu);
  cudaFree(countFlowGpu);
  


  return middleValue;;
}
