#include <iostream>
#References (Alias)
#must be initialized ,and match the type exactly. (only in define) 
#forexampel int &refVal5 =  an int object.
int main()
{
    int i = 0,&r1=i;
    double d = 0, &r2 = d;
    r2 = 3.14159;
    r2 = r1;
    i = r2;
    r1 = d;
    double dval = 3.14;
    int &refVal5 = d;
    std::cout << r2 << std::endl;
}
