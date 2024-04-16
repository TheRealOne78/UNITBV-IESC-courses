#include <iostream>

#include "triunghi.hpp"

using std::cout;
using std::endl;

int main() {
    Triunghi t1(3, 10, 11.6, 18.3, 2.5, 14.9);

    cout << "Aria triunghiului este " << t1.arie() << endl;

    t1.setV1(4, 8);
    t1.setV2(4, 2);
    t1.setV3(6, 2);

    cout << "Noile coordonate ale varfurilor sunt: [(" << t1.getV1x() << ","
         << t1.getV1y() << ");(" << t1.getV2x() << "," << t1.getV2y() << ");("
         << t1.getV3x() << "," << t1.getV3y() << ")]" << endl;

    cout << "Aria triunghiului este: " << t1.arie() << endl;

    cout << "Triunghiul este dreptunghic? " << t1.isDreptunghic() << endl;

    cout << "l1: " << t1.getLengthLatura_1() << "; l2: " << t1.getLengthLatura_2() << "; l3: " << t1.getLengthLatura_3() << endl;

    return 0;
}
