#include "../mtlpp.hpp"
#include <stdio.h>

int main()
{
    const uint32_t width  = 16;
    const uint32_t height = 16;

    mtlpp::Device device = mtlpp::Device::CreateSystemDefaultDevice();
    assert(device);

    mtlpp::TextureDescriptor textureDesc = mtlpp::TextureDescriptor::Texture2DDescriptor(
        mtlpp::PixelFormat::R8Unorm, width, height, false);
    textureDesc.SetUsage(mtlpp::TextureUsage::RenderTarget);
    mtlpp::Texture texture = device.NewTexture(textureDesc);
    assert(texture);

    const char shadersSrc[] = R"""(
        #include <metal_stdlib>
        using namespace metal;

        vertex float4 vertFunc (
            const device packed_float3* vertexArray [[buffer(0)]],
            unsigned int vID[[vertex_id]])
        {
            return float4(vertexArray[vID], 1.0);
        }

        fragment half4 fragFunc ()
        {
            return half4(1.0);
        }
    )""";

    mtlpp::Library library = device.NewLibrary(shadersSrc, mtlpp::CompileOptions(), nullptr);
    assert(library);
    mtlpp::Function vertFunc = library.NewFunction("vertFunc");
    assert(vertFunc);
    mtlpp::Function fragFunc = library.NewFunction("fragFunc");
    assert(fragFunc);

    mtlpp::RenderPipelineDescriptor renderPipelineDesc;
    renderPipelineDesc.SetVertexFunction(vertFunc);
    renderPipelineDesc.SetFragmentFunction(fragFunc);
    renderPipelineDesc.GetColorAttachments()[0].SetPixelFormat(mtlpp::PixelFormat::R8Unorm);
    mtlpp::RenderPipelineState renderPipelineState = device.NewRenderPipelineState(renderPipelineDesc, nullptr);
    assert(renderPipelineState);

    const float vertexData[] =
    {
         0.0f,  1.0f, 0.0f,
        -1.0f, -1.0f, 0.0f,
         1.0f, -1.0f, 0.0f,
    };
    mtlpp::Buffer vertexBuffer = device.NewBuffer(vertexData, sizeof(vertexData), mtlpp::ResourceOptions::CpuCacheModeDefaultCache);
    assert(vertexBuffer);

    mtlpp::CommandQueue commandQueue = device.NewCommandQueue();
    assert(commandQueue);
    mtlpp::CommandBuffer commandBuffer = commandQueue.CommandBuffer();
    assert(commandBuffer);

    mtlpp::RenderPassDescriptor renderPassDesc;
    mtlpp::RenderPassColorAttachmentDescriptor colorAttachmentDesc = renderPassDesc.GetColorAttachments()[0];
    colorAttachmentDesc.SetTexture(texture);
    colorAttachmentDesc.SetLoadAction(mtlpp::LoadAction::Clear);
    colorAttachmentDesc.SetStoreAction(mtlpp::StoreAction::Store);
    colorAttachmentDesc.SetClearColor(mtlpp::ClearColor(0.0, 0.0, 0.0, 0.0));
    renderPassDesc.SetRenderTargetArrayLength(1);

    mtlpp::RenderCommandEncoder renderCommandEncoder = commandBuffer.RenderCommandEncoder(renderPassDesc);
    assert(renderCommandEncoder);
    renderCommandEncoder.SetRenderPipelineState(renderPipelineState);
    renderCommandEncoder.SetVertexBuffer(vertexBuffer, 0, 0);
    renderCommandEncoder.Draw(mtlpp::PrimitiveType::Triangle, 0, 3);
    renderCommandEncoder.EndEncoding();

    mtlpp::BlitCommandEncoder blitCommandEncoder = commandBuffer.BlitCommandEncoder();
    blitCommandEncoder.Synchronize(texture, 0, 0);
    blitCommandEncoder.EndEncoding();

    commandBuffer.Commit();
    commandBuffer.WaitUntilCompleted();

    uint8_t data[width * height];
    texture.GetBytes(data, width, mtlpp::Region(0, 0, width, height), 0);

    for (uint32_t y=0; y<height; y++)
    {
        for (uint32_t x=0; x<width; x++)
        {
            printf("%02X ", data[x + y * width]);
        }
        printf("\n");
    }

    return 0;
}

