#include <iostream>
#include "randomizer.h"




int main () {

  unsigned length = 10000000;
  unsigned *vec = new unsigned[length];


  double result = randomizerGpu (vec, length, 10, 100);


  std::cout << result << "\n";
  return 0;
}
