#include "static.h"
#include "shared.h"

int main(int argc, char ** argv)
{
    StaticLibrary tobj;
    tobj.printTest();

    SharedLibrary lobj;
    lobj.printTest();

    return 0;
}
