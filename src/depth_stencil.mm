/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "depth_stencil.hpp"
#include <Metal/MTLDepthStencil.h>

namespace mtlpp
{
    StencilDescriptor::StencilDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLStencilDescriptor alloc] init] })
    {
    }

    CompareFunction StencilDescriptor::GetStencilCompareFunction() const
    {
        Validate();
        return CompareFunction([(__bridge MTLStencilDescriptor*)m_ptr stencilCompareFunction]);
    }

    StencilOperation StencilDescriptor::GetStencilFailureOperation() const
    {
        Validate();
        return StencilOperation([(__bridge MTLStencilDescriptor*)m_ptr stencilFailureOperation]);
    }

    StencilOperation StencilDescriptor::GetDepthFailureOperation() const
    {
        Validate();
        return StencilOperation([(__bridge MTLStencilDescriptor*)m_ptr depthFailureOperation]);
    }

    StencilOperation StencilDescriptor::GetDepthStencilPassOperation() const
    {
        Validate();
        return StencilOperation([(__bridge MTLStencilDescriptor*)m_ptr depthStencilPassOperation]);
    }

    uint32_t StencilDescriptor::GetReadMask() const
    {
        Validate();
        return uint32_t([(__bridge MTLStencilDescriptor*)m_ptr readMask]);
    }

    uint32_t StencilDescriptor::GetWriteMask() const
    {
        Validate();
        return uint32_t([(__bridge MTLStencilDescriptor*)m_ptr writeMask]);
    }

    void StencilDescriptor::SetStencilCompareFunction(CompareFunction stencilCompareFunction)
    {
        Validate();
        [(__bridge MTLStencilDescriptor*)m_ptr setStencilCompareFunction:MTLCompareFunction(stencilCompareFunction)];
    }

    void StencilDescriptor::SetStencilFailureOperation(StencilOperation stencilFailureOperation)
    {
        Validate();
        [(__bridge MTLStencilDescriptor*)m_ptr setStencilFailureOperation:MTLStencilOperation(stencilFailureOperation)];
    }

    void StencilDescriptor::SetDepthFailureOperation(StencilOperation depthFailureOperation)
    {
        Validate();
        [(__bridge MTLStencilDescriptor*)m_ptr setDepthFailureOperation:MTLStencilOperation(depthFailureOperation)];
    }

    void StencilDescriptor::SetDepthStencilPassOperation(StencilOperation depthStencilPassOperation)
    {
        Validate();
        [(__bridge MTLStencilDescriptor*)m_ptr setDepthStencilPassOperation:MTLStencilOperation(depthStencilPassOperation)];
    }

    void StencilDescriptor::SetReadMask(uint32_t readMask)
    {
        Validate();
        [(__bridge MTLStencilDescriptor*)m_ptr setReadMask:readMask];
    }

    void StencilDescriptor::SetWriteMask(uint32_t writeMask)
    {
        Validate();
        [(__bridge MTLStencilDescriptor*)m_ptr setWriteMask:writeMask];
    }

    DepthStencilDescriptor::DepthStencilDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLDepthStencilDescriptor alloc] init] })
    {
    }

    CompareFunction DepthStencilDescriptor::GetDepthCompareFunction() const
    {
        Validate();
        return CompareFunction([(__bridge MTLDepthStencilDescriptor*)m_ptr depthCompareFunction]);
    }

    bool DepthStencilDescriptor::IsDepthWriteEnabled() const
    {
        Validate();
        return [(__bridge MTLDepthStencilDescriptor*)m_ptr isDepthWriteEnabled];
    }

    StencilDescriptor DepthStencilDescriptor::GetFrontFaceStencil() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLDepthStencilDescriptor*)m_ptr frontFaceStencil] };
    }

    StencilDescriptor DepthStencilDescriptor::GetBackFaceStencil() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLDepthStencilDescriptor*)m_ptr backFaceStencil] };
    }

    ns::String DepthStencilDescriptor::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLDepthStencilDescriptor*)m_ptr label] };
    }

    void DepthStencilDescriptor::SetDepthCompareFunction(CompareFunction depthCompareFunction) const
    {
        Validate();
        [(__bridge MTLDepthStencilDescriptor*)m_ptr setDepthCompareFunction:MTLCompareFunction(depthCompareFunction)];
    }

    void DepthStencilDescriptor::SetDepthWriteEnabled(bool depthWriteEnabled) const
    {
        Validate();
        [(__bridge MTLDepthStencilDescriptor*)m_ptr setDepthWriteEnabled:depthWriteEnabled];
    }

    void DepthStencilDescriptor::SetFrontFaceStencil(const StencilDescriptor& frontFaceStencil) const
    {
        Validate();
        [(__bridge MTLDepthStencilDescriptor*)m_ptr setFrontFaceStencil:(__bridge MTLStencilDescriptor*)frontFaceStencil.GetPtr()];
    }

    void DepthStencilDescriptor::SetBackFaceStencil(const StencilDescriptor& backFaceStencil) const
    {
        Validate();
        [(__bridge MTLDepthStencilDescriptor*)m_ptr setBackFaceStencil:(__bridge MTLStencilDescriptor*)backFaceStencil.GetPtr()];
    }

    void DepthStencilDescriptor::SetLabel(const ns::String& label) const
    {
        Validate();
        [(__bridge MTLDepthStencilDescriptor*)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
    }

    ns::String DepthStencilState::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDepthStencilState>)m_ptr label] };
    }

    Device DepthStencilState::GetDevice() const
    {
        Validate();
        return ns::Handle { (__bridge void*)[(__bridge id<MTLDepthStencilState>)m_ptr device] };
    }
}
