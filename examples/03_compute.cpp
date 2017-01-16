#include "../mtlpp.hpp"
#include <stdio.h>

int main()
{
    mtlpp::Device device = mtlpp::Device::CreateSystemDefaultDevice();
    assert(device);

    const char shadersSrc[] = R"""(
        #include <metal_stdlib>
        using namespace metal;

        kernel void sqr(
            const device float *vIn [[ buffer(0) ]],
            device float *vOut [[ buffer(1) ]],
            uint id[[ thread_position_in_grid ]])
        {
            vOut[id] = vIn[id] * vIn[id];
        }
    )""";

    mtlpp::Library library = device.NewLibrary(shadersSrc, mtlpp::CompileOptions(), nullptr);
    assert(library);
    mtlpp::Function sqrFunc = library.NewFunction("sqr");
    assert(sqrFunc);

    mtlpp::ComputePipelineState computePipelineState = device.NewComputePipelineState(sqrFunc, nullptr);
    assert(computePipelineState);

    const uint32_t inDataCount = 8;
    const float inData[inDataCount] = { 0.0f, 1.0f, 2.0f, 10.0f, 11.0f, 12.0f, 20, 21 };

    mtlpp::Buffer inBuffer = device.NewBuffer(inData, sizeof(inData), mtlpp::ResourceOptions::CpuCacheModeDefaultCache);
    assert(inBuffer);

    mtlpp::Buffer outBuffer = device.NewBuffer(sizeof(inData), mtlpp::ResourceOptions::CpuCacheModeDefaultCache);
    assert(outBuffer);

    mtlpp::CommandQueue commandQueue = device.NewCommandQueue();
    assert(commandQueue);
    mtlpp::CommandBuffer commandBuffer = commandQueue.CommandBuffer();
    assert(commandBuffer);

    mtlpp::ComputeCommandEncoder commandEncoder = commandBuffer.ComputeCommandEncoder();
    commandEncoder.SetBuffer(inBuffer, 0, 0);
    commandEncoder.SetBuffer(outBuffer, 0, 1);
    commandEncoder.SetComputePipelineState(computePipelineState);

    commandEncoder.DispatchThreadgroups(
        mtlpp::Size(1, 1, 1),
        mtlpp::Size(inDataCount, 1, 1));

    commandEncoder.EndEncoding();
    commandBuffer.Commit();
    commandBuffer.WaitUntilCompleted();

    float* outData = static_cast<float*>(outBuffer.GetContents());
    for (uint32_t i=0; i<inDataCount; i++)
        printf("sqr(%g) = %g\n", inData[i], outData[i]);

    return 0;
}

