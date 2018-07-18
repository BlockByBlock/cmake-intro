#include <iostream>

#include "static.h"

StaticLibrary::StaticLibrary(): helloworld(27){}

void StaticLibrary::printTest()
{
    std::cout << helloworld << std::endl;
}

