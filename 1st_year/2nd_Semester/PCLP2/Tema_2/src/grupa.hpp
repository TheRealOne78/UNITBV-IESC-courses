#include "student.hpp"
#include <cstdint>
#include <vector>

class Grupa : public Student {
        public:
                /* Constructors and destructors */
                Grupa() {}

                ~Grupa();

                /* Getters */
                void getStudentIDs(); // print
                Student getStudentByID(uint16_t);

                /* Misc */
                void addStudent(uint16_t, char *, char *, float, float, float);
                void delStudent(uint16_t);
                void delStudentAuto();

                bool isIDInGroup(uint16_t);

                float getStudentCount();

                void printAllBursaStudiu();
                void printAllBursaMerit();

                void printStudentByID(uint16_t);

        private:
                std::vector<Student> student_list;

                float studentCount;
};
