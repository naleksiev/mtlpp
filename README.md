[![Build Status](https://travis-ci.org/naleksiev/mtlpp.svg?branch=master)](https://travis-ci.org/naleksiev/mtlpp)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/naleksiev/mtlpp/blob/master/LICENSE)
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

### Main features
 * Complete API wrapper (iOS 10, tvOS 10, and OS X 10.12).
 * Objective-C free headers - allow compiling agains the Metal API on any platform (**no linking**).
 * Configurable AVAILABILITY and DEPRECATED validation.
 * Amalgamated ```mtlpp.hpp``` and ```mtlpp.mm``` - of course you can still use the content of ```src/``` folder.
