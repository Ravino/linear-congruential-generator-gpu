#include "worker.h"


__global__ void worker (unsigned *vecGpu, unsigned *poolBGpu, unsigned *poolXGpu, unsigned *countFlowGpu, unsigned *lengthGpu, double *poolMiddleValueGpu, unsigned *minGpu, unsigned *maxGpu, unsigned *lastAGpu) {

  double currentMiddleValue = 0.0;


  unsigned flow = threadIdx.x;


  unsigned b = poolBGpu[flow];
  unsigned x = poolXGpu[flow];


  unsigned lastA = *lastAGpu;
  unsigned countFlow = *countFlowGpu;
  unsigned length = *lengthGpu;
  unsigned min = *minGpu;
  unsigned max = *maxGpu;


  for (unsigned i = flow; i < length; i + countFlow) {
    vecGpu[i] = (x % (max - min)) + min;
    currentMiddleValue += (double)vecGpu[i];
    x = x * lastA + b;;
  }


  poolMiddleValueGpu[flow] = currentMiddleValue;
}
