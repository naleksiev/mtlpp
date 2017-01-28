#pragma once

#include "../mtlpp.hpp"

class Window
{
public:
    Window(const mtlpp::Device& device, void (*render)(const Window&), int32_t width, int32_t height);

    uint32_t GetWidth() const;
    uint32_t GetHeight() const;
    mtlpp::Drawable GetDrawable() const;
    mtlpp::RenderPassDescriptor GetRenderPassDescriptor() const;

    static void Run();

private:
    class MtlView : public ns::Object
    {
    public:
        MtlView() { }
        MtlView(const ns::Handle& handle) : ns::Object(handle) { }
    };

    MtlView m_view;
};

