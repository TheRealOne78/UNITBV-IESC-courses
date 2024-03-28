#include <iostream>

class Patrulater {
    public:
        Patrulater(double v1, double v2, double v3, double v4){
            L1 = v1; L2 = v2; L3 = v3; L4 = v4;
        }

        double perimetru(){
            return L1+L2+L3+L4;
        }

    protected:
        double L1, L2, L3, L4;
};

class Paralelogram : public Patrulater {

    public:
        Paralelogram(double L1, double L2) : Patrulater(L1, L2, L1, L2) {}

};


std::ostream& operator<<(std::ostream& o, Paralelogram& pr) {
    o << "L1 = L3 = " << pr.L1 << ";L2=L4" << pr.L2;
    return o;
}

int main() {
    Patrulater p1(10.f, 12.f, 8.4f, 2.f);
    Paralelogram p2(11.f, 5.2);

    std::cout << p1.perimetru() << std::endl;
    std::cout << p2 << std::endl;

    return 0;
}
