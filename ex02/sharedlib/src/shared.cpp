#include <iostream>

#include "shared.h"

SharedLibrary::SharedLibrary(): helloworld(36){}

void SharedLibrary::printTest()
{
    std::cout << helloworld << std::endl;
}

