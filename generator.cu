#include <ctime>
#include "generator.h"


#define A 1103515245u
#define B 12345u
#define C 4294967296u




unsigned * createPoolA(unsigned countFlow) {

  unsigned *vec = new unsigned[countFlow];


    vec[0] = A;


  for (unsigned i = 1; i < countFlow + 1; i++) {

    unsigned currentA = vec[i-1];
    unsigned lastA = (currentA * A) % C;


    vec[i] = lastA;
  }


  return vec;
}




unsigned * createPoolB(unsigned *multiplier, unsigned countFlow) {

  unsigned *vec = new unsigned[countFlow];
  unsigned lastA = multiplier[countFlow];


  for(unsigned i = 0; i < countFlow; i++) {
    vec[i] = (B * (lastA - 1) / (A - 1)) % C;
  }


  return vec;
}




unsigned * createPoolX(unsigned *multiplier, unsigned countFlow) {

  unsigned *vec = new unsigned[countFlow];
  unsigned seed = std::time(nullptr);


  for(unsigned i = 0; i < countFlow; i++) {
    vec[i] = ((seed * multiplier[i]) % C + (B * (multiplier[i] - 1) / (A - 1)) % C) % C;
  }


  return vec;
}




unsigned getLastA(unsigned * multiplier, unsigned countFlow) {
  unsigned lastA = multiplier[countFlow];
  return lastA;
}
