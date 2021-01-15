#include <iostream>
#include <vector>
#include "randomizer.h"




int main () {

  unsigned length = 10000000;
  //unsigned *vec = new unsigned[length];
  std::vector<unsigned> vec(length);

  double result = randomizerGpu (vec.data(), vec.size(), 10, 100);


  std::cout << result << "\n";
  return 0;
}
