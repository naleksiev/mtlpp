#include "../mtlpp.hpp"

int main()
{
    mtlpp::Device device = mtlpp::Device::CreateSystemDefaultDevice();
    assert(device);
    return 0;
}

