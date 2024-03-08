#include <iostream>
#include <fstream>

using namespace std;

int main() {
    int inaltime;
    int latime;
    ifstream fisierDate;

    fisierDate.open("dimensiuni.dat");

    if (!fisierDate) {
        cout << "Nu pot deschide fisierul de date." << endl;

        return 1;
    }

    fisierDate >> inaltime >> latime;
    cout << inaltime * latime;

    return 0;
}
