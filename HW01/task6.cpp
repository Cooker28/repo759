#include <cstdlib>
#include <iostream>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        return 1;
    }

    int numInc = std::atoi(argv[1]);

    for (int i = 0; i <= numInc; ++i) {
        std::cout << i << " ";
    }
    std::cout << std::endl;

    for (int i = numInc; i >= 0; --i) {
        std::cout << i << " ";
    }
    std::cout << std::endl;

    return 0;

}