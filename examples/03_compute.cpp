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

    mtlpp::CommandQueue commandQueue = device.NewCommandQueue();
    assert(commandQueue);

    const uint32_t dataCount = 6;

    mtlpp::Buffer inBuffer = device.NewBuffer(sizeof(float) * dataCount, mtlpp::ResourceOptions::StorageModeManaged);
    assert(inBuffer);

    mtlpp::Buffer outBuffer = device.NewBuffer(sizeof(float) * dataCount, mtlpp::ResourceOptions::StorageModeManaged);
    assert(outBuffer);

    for (uint32_t i=0; i<4; i++)
    {
        // update input data
        {
            float* inData = static_cast<float*>(inBuffer.GetContents());
            for (uint32_t j=0; j<dataCount; j++)
                inData[j] = 10 * i + j;
            inBuffer.DidModify(ns::Range(0, sizeof(float) * dataCount));
        }

        mtlpp::CommandBuffer commandBuffer = commandQueue.CommandBuffer();
        assert(commandBuffer);

        mtlpp::ComputeCommandEncoder commandEncoder = commandBuffer.ComputeCommandEncoder();
        commandEncoder.SetBuffer(inBuffer, 0, 0);
        commandEncoder.SetBuffer(outBuffer, 0, 1);
        commandEncoder.SetComputePipelineState(computePipelineState);
        commandEncoder.DispatchThreadgroups(
            mtlpp::Size(1, 1, 1),
            mtlpp::Size(dataCount, 1, 1));
        commandEncoder.EndEncoding();

        mtlpp::BlitCommandEncoder blitCommandEncoder = commandBuffer.BlitCommandEncoder();
        blitCommandEncoder.Synchronize(outBuffer);
        blitCommandEncoder.EndEncoding();

        commandBuffer.Commit();
        commandBuffer.WaitUntilCompleted();

        // read the data
        {
            float* inData = static_cast<float*>(inBuffer.GetContents());
            float* outData = static_cast<float*>(outBuffer.GetContents());
            for (uint32_t j=0; j<dataCount; j++)
                printf("sqr(%g) = %g\n", inData[j], outData[j]);
        }
    }

    return 0;
}

