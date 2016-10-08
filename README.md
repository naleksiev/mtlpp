[![Build Status](https://travis-ci.org/naleksiev/mtlpp.svg?branch=master)](https://travis-ci.org/naleksiev/mtlpp)
## mtlpp - C++ wrapper around Metal 

Complete wrapper around Metal (Apple's low-level graphics API).

```c++
#include "mtlpp.hpp"

int main()
{
    mtlpp::Device device = mtlpp::Device::CreateSystemDefaultDevice();

    mtlpp::CommandQueue commandQueue = device.NewCommandQueue();
    mtlpp::CommandBuffer commandBuffer = commandQueue.CommandBuffer();
 
    mtlpp::TextureDescriptor textureDesc = mtlpp::TextureDescriptor::Texture2DDescriptor(
        mtlpp::PixelFormat::RGBA8Unorm, 320, 240, false);
    textureDesc.SetUsage(mtlpp::TextureUsage::RenderTarget);
    mtlpp::Texture texture = device.NewTexture(textureDesc);
    
    return 0;
}
```
