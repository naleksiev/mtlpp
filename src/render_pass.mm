/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "render_pass.hpp"
#include "texture.hpp"
#include <Metal/MTLRenderPass.h>

namespace mtlpp
{
    RenderPassAttachmentDescriptor::RenderPassAttachmentDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLRenderPassAttachmentDescriptor alloc] init] })
    {
    }

    Texture RenderPassAttachmentDescriptor::GetTexture() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr texture] };
    }

    uint32_t RenderPassAttachmentDescriptor::GetLevel() const
    {
        Validate();
        return uint32_t([(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr level]);
    }

    uint32_t RenderPassAttachmentDescriptor::GetSlice() const
    {
        Validate();
        return uint32_t([(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr slice]);
    }

    uint32_t RenderPassAttachmentDescriptor::GetDepthPlane() const
    {
        Validate();
        return uint32_t([(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr depthPlane]);
    }

    Texture RenderPassAttachmentDescriptor::GetResolveTexture() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr resolveTexture] };
    }

    uint32_t RenderPassAttachmentDescriptor::GetResolveLevel() const
    {
        Validate();
        return uint32_t([(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr resolveLevel]);
    }

    uint32_t RenderPassAttachmentDescriptor::GetResolveSlice() const
    {
        Validate();
        return uint32_t([(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr resolveSlice]);
    }

    uint32_t RenderPassAttachmentDescriptor::GetResolveDepthPlane() const
    {
        Validate();
        return uint32_t([(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr resolveDepthPlane]);
    }

    LoadAction RenderPassAttachmentDescriptor::GetLoadAction() const
    {
        Validate();
        return LoadAction([(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr loadAction]);
    }

    StoreAction RenderPassAttachmentDescriptor::GetStoreAction() const
    {
        Validate();
        return StoreAction([(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr storeAction]);
    }

    void RenderPassAttachmentDescriptor::SetTexture(const Texture& texture)
    {
        Validate();
        [(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr setTexture:(__bridge id<MTLTexture>)texture.GetPtr()];
    }

    void RenderPassAttachmentDescriptor::SetLevel(uint32_t level)
    {
        Validate();
        [(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr setLevel:level];
    }

    void RenderPassAttachmentDescriptor::SetSlice(uint32_t slice)
    {
        Validate();
        [(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr setSlice:slice];
    }

    void RenderPassAttachmentDescriptor::SetDepthPlane(uint32_t depthPlane)
    {
        Validate();
        [(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr setDepthPlane:depthPlane];
    }

    void RenderPassAttachmentDescriptor::SetResolveTexture(const Texture& texture)
    {
        Validate();
        [(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr setResolveTexture:(__bridge id<MTLTexture>)texture.GetPtr()];
    }

    void RenderPassAttachmentDescriptor::SetResolveLevel(uint32_t resolveLevel)
    {
        Validate();
        [(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr setResolveLevel:resolveLevel];
    }

    void RenderPassAttachmentDescriptor::SetResolveSlice(uint32_t resolveSlice)
    {
        Validate();
        [(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr setResolveSlice:resolveSlice];
    }

    void RenderPassAttachmentDescriptor::SetResolveDepthPlane(uint32_t resolveDepthPlane)
    {
        Validate();
        [(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr setResolveDepthPlane:resolveDepthPlane];
    }

    void RenderPassAttachmentDescriptor::SetLoadAction(LoadAction loadAction)
    {
        Validate();
        [(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr setLoadAction:MTLLoadAction(loadAction)];
    }

    void RenderPassAttachmentDescriptor::SetStoreAction(StoreAction storeAction)
    {
        Validate();
        [(__bridge MTLRenderPassAttachmentDescriptor*)m_ptr setStoreAction:MTLStoreAction(storeAction)];
    }

    RenderPassColorAttachmentDescriptor::RenderPassColorAttachmentDescriptor() :
        RenderPassAttachmentDescriptor(ns::Handle{ (__bridge void*)[[MTLRenderPassColorAttachmentDescriptor alloc] init] })
    {
    }

    ClearColor RenderPassColorAttachmentDescriptor::GetClearColor() const
    {
        Validate();
        MTLClearColor mtlClearColor = [(__bridge MTLRenderPassColorAttachmentDescriptor*)m_ptr clearColor];
        return ClearColor(mtlClearColor.red, mtlClearColor.green, mtlClearColor.blue, mtlClearColor.alpha);
    }

    void RenderPassColorAttachmentDescriptor::SetClearColor(const ClearColor& clearColor)
    {
        Validate();
        MTLClearColor mtlClearColor = { clearColor.Red, clearColor.Green, clearColor.Blue, clearColor.Alpha };
        [(__bridge MTLRenderPassColorAttachmentDescriptor*)m_ptr setClearColor:mtlClearColor];
    }

    RenderPassDepthAttachmentDescriptor::RenderPassDepthAttachmentDescriptor() :
        RenderPassAttachmentDescriptor(ns::Handle{ (__bridge void*)[[MTLRenderPassDepthAttachmentDescriptor alloc] init] })
    {
    }

    double RenderPassDepthAttachmentDescriptor::GetClearDepth() const
    {
        Validate();
        return [(__bridge MTLRenderPassDepthAttachmentDescriptor*)m_ptr clearDepth];
    }

    MultisampleDepthResolveFilter RenderPassDepthAttachmentDescriptor::GetDepthResolveFilter() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(9_0)
        return MultisampleDepthResolveFilter([(__bridge MTLRenderPassDepthAttachmentDescriptor*)m_ptr depthResolveFilter]);
#else
        return MultisampleDepthResolveFilter(0);
#endif
    }

    void RenderPassDepthAttachmentDescriptor::SetClearDepth(double clearDepth)
    {
        Validate();
        [(__bridge MTLRenderPassDepthAttachmentDescriptor*)m_ptr setClearDepth:clearDepth];
    }

    void RenderPassDepthAttachmentDescriptor::SetDepthResolveFilter(MultisampleDepthResolveFilter depthResolveFilter)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(9_0)
        [(__bridge MTLRenderPassDepthAttachmentDescriptor*)m_ptr setDepthResolveFilter:MTLMultisampleDepthResolveFilter(depthResolveFilter)];
#endif
    }

    RenderPassStencilAttachmentDescriptor::RenderPassStencilAttachmentDescriptor() :
        RenderPassAttachmentDescriptor(ns::Handle{ (__bridge void*)[[MTLRenderPassStencilAttachmentDescriptor alloc] init] })
    {
    }

    uint32_t RenderPassStencilAttachmentDescriptor::GetClearStencil() const
    {
        Validate();
        return uint32_t([(__bridge MTLRenderPassStencilAttachmentDescriptor*)m_ptr clearStencil]);
    }

    void RenderPassStencilAttachmentDescriptor::SetClearStencil(uint32_t clearStencil)
    {
        Validate();
        [(__bridge MTLRenderPassStencilAttachmentDescriptor*)m_ptr setClearStencil:clearStencil];
    }

    RenderPassDescriptor::RenderPassDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLRenderPassDescriptor alloc] init] })
    {
    }

    ns::Array<RenderPassColorAttachmentDescriptor> RenderPassDescriptor::GetColorAttachments() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPassDescriptor*)m_ptr colorAttachments] };
    }

    RenderPassDepthAttachmentDescriptor RenderPassDescriptor::GetDepthAttachment() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPassDescriptor*)m_ptr depthAttachment] };
    }

    RenderPassStencilAttachmentDescriptor RenderPassDescriptor::GetStencilAttachment() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPassDescriptor*)m_ptr stencilAttachment] };
    }

    Buffer RenderPassDescriptor::GetVisibilityResultBuffer() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPassDescriptor*)m_ptr visibilityResultBuffer] };
    }

    uint32_t RenderPassDescriptor::GetRenderTargetArrayLength() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        return uint32_t([(__bridge MTLRenderPassDescriptor*)m_ptr renderTargetArrayLength]);
#else
        return 0;
#endif
    }

    void RenderPassDescriptor::SetDepthAttachment(const RenderPassDepthAttachmentDescriptor& depthAttachment)
    {
        Validate();
        [(__bridge MTLRenderPassDescriptor*)m_ptr setDepthAttachment:(__bridge MTLRenderPassDepthAttachmentDescriptor*)depthAttachment.GetPtr()];
    }

    void RenderPassDescriptor::SetStencilAttachment(const RenderPassStencilAttachmentDescriptor& stencilAttachment)
    {
        Validate();
        [(__bridge MTLRenderPassDescriptor*)m_ptr setStencilAttachment:(__bridge MTLRenderPassStencilAttachmentDescriptor*)stencilAttachment.GetPtr()];
    }

    void RenderPassDescriptor::SetVisibilityResultBuffer(const Buffer& visibilityResultBuffer)
    {
        Validate();
        [(__bridge MTLRenderPassDescriptor*)m_ptr setVisibilityResultBuffer:(__bridge id<MTLBuffer>)visibilityResultBuffer.GetPtr()];
    }

    void RenderPassDescriptor::SetRenderTargetArrayLength(uint32_t renderTargetArrayLength)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        [(__bridge MTLRenderPassDescriptor*)m_ptr setRenderTargetArrayLength:renderTargetArrayLength];
#endif
    }
}
