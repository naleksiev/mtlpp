#include "../mtlpp.hpp"
#include "window.hpp"

mtlpp::Device       g_device;
mtlpp::CommandQueue g_commandQueue;

void Render(const Window& win)
{
    uint32_t width = win.GetWidth();
    uint32_t height = win.GetHeight();

    mtlpp::CommandBuffer commandBuffer = g_commandQueue.CommandBuffer();
    assert(commandBuffer);

    mtlpp::RenderPassDescriptor renderPassDesc = win.GetRenderPassDescriptor();
    if (renderPassDesc)
    {
        mtlpp::RenderCommandEncoder renderCommandEncoder = commandBuffer.RenderCommandEncoder(renderPassDesc);
        assert(renderCommandEncoder);
        renderCommandEncoder.EndEncoding();
        commandBuffer.Present(win.GetDrawable());
    }

    commandBuffer.Commit();
    commandBuffer.WaitUntilCompleted();
}

int main()
{
    g_device = mtlpp::Device::CreateSystemDefaultDevice();
    g_commandQueue = g_device.NewCommandQueue();

    Window win(g_device, &Render, 320, 240);
    Window::Run();

    return 0;
}

