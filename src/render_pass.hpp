/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"

namespace mtlpp
{
    class Texture;
    class Buffer;

    enum class LoadAction
    {
        DontCare = 0,
        Load     = 1,
        Clear    = 2,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class StoreAction
    {
        DontCare                                               = 0,
        Store                                                  = 1,
        MultisampleResolve                                     = 2,
        StoreAndMultisampleResolve MTLPP_AVAILABLE(10_12,10_0) = 3,
        Unknown                    MTLPP_AVAILABLE(10_12,10_0) = 4,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class MultisampleDepthResolveFilter
    {
        Sample0 = 0,
        Min     = 1,
        Max     = 2,
    }
    MTLPP_AVAILABLE_IOS(9_0);

    struct ClearColor
    {
        ClearColor(double red, double green, double blue, double alpha) :
            Red(red),
            Green(green),
            Blue(blue),
            Alpha(alpha) { }

        double Red;
        double Green;
        double Blue;
        double Alpha;
    };

    class RenderPassAttachmentDescriptor : public ns::Object
    {
    public:
        RenderPassAttachmentDescriptor();
        RenderPassAttachmentDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        Texture     GetTexture() const;
        uint32_t    GetLevel() const;
        uint32_t    GetSlice() const;
        uint32_t    GetDepthPlane() const;
        Texture     GetResolveTexture() const;
        uint32_t    GetResolveLevel() const;
        uint32_t    GetResolveSlice() const;
        uint32_t    GetResolveDepthPlane() const;
        LoadAction  GetLoadAction() const;
        StoreAction GetStoreAction() const;

        void SetTexture(const Texture& texture);
        void SetLevel(uint32_t level);
        void SetSlice(uint32_t slice);
        void SetDepthPlane(uint32_t depthPlane);
        void SetResolveTexture(const Texture& texture);
        void SetResolveLevel(uint32_t resolveLevel);
        void SetResolveSlice(uint32_t resolveSlice);
        void SetResolveDepthPlane(uint32_t resolveDepthPlane);
        void SetLoadAction(LoadAction loadAction);
        void SetStoreAction(StoreAction storeAction);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class RenderPassColorAttachmentDescriptor : public RenderPassAttachmentDescriptor
    {
    public:
        RenderPassColorAttachmentDescriptor();
        RenderPassColorAttachmentDescriptor(const ns::Handle& handle) : RenderPassAttachmentDescriptor(handle) { }

        ClearColor GetClearColor() const;

        void SetClearColor(const ClearColor& clearColor);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class RenderPassDepthAttachmentDescriptor : public RenderPassAttachmentDescriptor
    {
    public:
        RenderPassDepthAttachmentDescriptor();
        RenderPassDepthAttachmentDescriptor(const ns::Handle& handle) : RenderPassAttachmentDescriptor(handle) { }

        double                        GetClearDepth() const;
        MultisampleDepthResolveFilter GetDepthResolveFilter() const MTLPP_AVAILABLE_IOS(9_0);

        void SetClearDepth(double clearDepth);
        void SetDepthResolveFilter(MultisampleDepthResolveFilter depthResolveFilter) MTLPP_AVAILABLE_IOS(9_0);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class RenderPassStencilAttachmentDescriptor : public RenderPassAttachmentDescriptor
    {
    public:
        RenderPassStencilAttachmentDescriptor();
        RenderPassStencilAttachmentDescriptor(const ns::Handle& handle) : RenderPassAttachmentDescriptor(handle) { }

        uint32_t GetClearStencil() const;

        void SetClearStencil(uint32_t clearStencil);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class RenderPassDescriptor : public ns::Object
    {
    public:
        RenderPassDescriptor();
        RenderPassDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        ns::Array<RenderPassColorAttachmentDescriptor> GetColorAttachments() const;
        RenderPassDepthAttachmentDescriptor   GetDepthAttachment() const;
        RenderPassStencilAttachmentDescriptor GetStencilAttachment() const;
        Buffer                                GetVisibilityResultBuffer() const;
        uint32_t                              GetRenderTargetArrayLength() const MTLPP_AVAILABLE_MAC(10_11);

        void SetDepthAttachment(const RenderPassDepthAttachmentDescriptor& depthAttachment);
        void SetStencilAttachment(const RenderPassStencilAttachmentDescriptor& stencilAttachment);
        void SetVisibilityResultBuffer(const Buffer& visibilityResultBuffer);
        void SetRenderTargetArrayLength(uint32_t renderTargetArrayLength) MTLPP_AVAILABLE_MAC(10_11);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
