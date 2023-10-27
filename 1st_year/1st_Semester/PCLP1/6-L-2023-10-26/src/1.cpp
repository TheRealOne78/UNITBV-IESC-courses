#include <iostream>
//using namespace std;

int Patrat(int);
int Cub(int);

int main() {
  std::cout << "Patratul lui 27 este " << Patrat(27) << std::endl;
  std::cout << "si cubul lui 27 este " << Cub(27) << std::endl;

  return 0;
}

int Patrat(int n) {
  return n*n;
}

int Cub(int n) {
  return n*n*n;
}
