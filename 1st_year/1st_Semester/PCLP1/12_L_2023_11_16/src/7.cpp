#include <iostream>

int main() {
   int x = 2, y = 5, z = 15;

   // a) x, y şi z sunt mai mari decât 0
   if (x > 0 && y > 0 && z > 0)
       std::cout << "x, y, z mai mari decat 0\n";

   // b) x nu este egal nici cu y nici cu z
   if (x != y && x != z)
       std::cout << "x nu este egal nici cu y nici cu z\n";

   // c) x este egal cu y şi cu z
   if (x == y && x == z)
       std::cout << "x este egal cu y şi cu z\n";

   // d) x este mai mic decât y, iar y este mai mic sau egal cu z
   if (x < y && y <= z)
       std::cout << "x este mai mic decât y, iar y este mai mic sau egal cu z" << std::endl;

   return 0;
}
