/* Completaţi spaţiile din următorul program:
 *
 * #include ___
 * ___
 *
 * const float PI = 3.14159; //Raportul dintre lungimea şi diametrul unui cerc
 *
 * int ___ ()
 * ___
 *   float lungimea;  //Lungimea unui cerc
 *
 *   lungimea ___ PI * 7.8;
 *   cout << “Lungimea unui cerc ”;
 *   cout << “ cu diametrul 7.8 este “ ___ endl;
 *   ___ << lungimea ___ endl;
 *
 *   return ___;
 * ___
 */

#include <iostream>

//using namespace std;

const float PI = 3.14159;  //Raportul dintre lungimea şi diametrul unui cerc

int main () {
  float lungimea; //Lungimea unui cerc

  lungimea = PI * 7.8;
  std::cout << "Lungimea unui cerc ";
  std::cout << "cu diametrul 7.8 este " << std::endl;
  std::cout << lungimea << std::endl;

  return 0;

}
