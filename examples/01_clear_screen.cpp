#include "../mtlpp.hpp"

int main()
{
    const uint32_t width  = 4;
    const uint32_t height = 4;

    mtlpp::Device device = mtlpp::Device::CreateSystemDefaultDevice();

    mtlpp::TextureDescriptor textureDesc = mtlpp::TextureDescriptor::Texture2DDescriptor(
        mtlpp::PixelFormat::RGBA8Unorm, width, height, false);
    textureDesc.SetUsage(mtlpp::TextureUsage::RenderTarget);
    mtlpp::Texture texture = device.NewTexture(textureDesc);

    mtlpp::CommandQueue commandQueue = device.NewCommandQueue();
    mtlpp::CommandBuffer commandBuffer = commandQueue.CommandBuffer();

    mtlpp::RenderPassDescriptor renderPassDesc;
    mtlpp::RenderPassColorAttachmentDescriptor colorAttachmentDesc = renderPassDesc.GetColorAttachments()[0];
    colorAttachmentDesc.SetTexture(texture);
    colorAttachmentDesc.SetLoadAction(mtlpp::LoadAction::Clear);
    colorAttachmentDesc.SetStoreAction(mtlpp::StoreAction::Store);
    colorAttachmentDesc.SetClearColor(mtlpp::ClearColor(1.0, 0.0, 0.0, 0.0));
    renderPassDesc.SetRenderTargetArrayLength(1);
    mtlpp::RenderCommandEncoder renderCommandEncoder = commandBuffer.RenderCommandEncoder(renderPassDesc);

    renderCommandEncoder.EndEncoding();

    commandBuffer.Commit();
    commandBuffer.WaitUntilCompleted();

    uint32_t data[width * height];
    texture.GetBytes(data, width * 4, mtlpp::Region(0, 0, width, height), 0);

    for (uint32_t i=0; i<width*height; i++)
    {
        assert(data[i] == 0x000000FF);
    }

    return 0;
}

