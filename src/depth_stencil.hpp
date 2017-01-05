/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"
#include "device.hpp"

namespace mtlpp
{
    enum class CompareFunction
    {
        Never        = 0,
        Less         = 1,
        Equal        = 2,
        LessEqual    = 3,
        Greater      = 4,
        NotEqual     = 5,
        GreaterEqual = 6,
        Always       = 7,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class StencilOperation
    {
        Keep           = 0,
        Zero           = 1,
        Replace        = 2,
        IncrementClamp = 3,
        DecrementClamp = 4,
        Invert         = 5,
        IncrementWrap  = 6,
        DecrementWrap  = 7,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class StencilDescriptor : public ns::Object
    {
    public:
        StencilDescriptor();
        StencilDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        CompareFunction  GetStencilCompareFunction() const;
        StencilOperation GetStencilFailureOperation() const;
        StencilOperation GetDepthFailureOperation() const;
        StencilOperation GetDepthStencilPassOperation() const;
        uint32_t         GetReadMask() const;
        uint32_t         GetWriteMask() const;

        void SetStencilCompareFunction(CompareFunction stencilCompareFunction);
        void SetStencilFailureOperation(StencilOperation stencilFailureOperation);
        void SetDepthFailureOperation(StencilOperation depthFailureOperation);
        void SetDepthStencilPassOperation(StencilOperation depthStencilPassOperation);
        void SetReadMask(uint32_t readMask);
        void SetWriteMask(uint32_t writeMask);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class DepthStencilDescriptor : public ns::Object
    {
    public:
        DepthStencilDescriptor();
        DepthStencilDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        CompareFunction   GetDepthCompareFunction() const;
        bool              IsDepthWriteEnabled() const;
        StencilDescriptor GetFrontFaceStencil() const;
        StencilDescriptor GetBackFaceStencil() const;
        ns::String        GetLabel() const;

        void SetDepthCompareFunction(CompareFunction depthCompareFunction) const;
        void SetDepthWriteEnabled(bool depthWriteEnabled) const;
        void SetFrontFaceStencil(const StencilDescriptor& frontFaceStencil) const;
        void SetBackFaceStencil(const StencilDescriptor& backFaceStencil) const;
        void SetLabel(const ns::String& label) const;
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class DepthStencilState : public ns::Object
    {
    public:
        DepthStencilState() { }
        DepthStencilState(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String GetLabel() const;
        Device     GetDevice() const;
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
