/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "sampler.hpp"
#include <Metal/MTLSampler.h>

namespace mtlpp
{
    SamplerDescriptor::SamplerDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLSamplerDescriptor alloc] init] })
    {
    }

    SamplerMinMagFilter SamplerDescriptor::GetMinFilter() const
    {
        Validate();
        return SamplerMinMagFilter([(__bridge MTLSamplerDescriptor*)m_ptr minFilter]);
    }

    SamplerMinMagFilter SamplerDescriptor::GetMagFilter() const
    {
        Validate();
        return SamplerMinMagFilter([(__bridge MTLSamplerDescriptor*)m_ptr magFilter]);
    }

    SamplerMipFilter SamplerDescriptor::GetMipFilter() const
    {
        Validate();
        return SamplerMipFilter([(__bridge MTLSamplerDescriptor*)m_ptr mipFilter]);
    }

    uint32_t SamplerDescriptor::GetMaxAnisotropy() const
    {
        Validate();
        return uint32_t([(__bridge MTLSamplerDescriptor*)m_ptr maxAnisotropy]);
    }

    SamplerAddressMode SamplerDescriptor::GetSAddressMode() const
    {
        Validate();
        return SamplerAddressMode([(__bridge MTLSamplerDescriptor*)m_ptr sAddressMode]);
    }

    SamplerAddressMode SamplerDescriptor::GetTAddressMode() const
    {
        Validate();
        return SamplerAddressMode([(__bridge MTLSamplerDescriptor*)m_ptr tAddressMode]);
    }

    SamplerAddressMode SamplerDescriptor::GetRAddressMode() const
    {
        Validate();
        return SamplerAddressMode([(__bridge MTLSamplerDescriptor*)m_ptr rAddressMode]);
    }

    SamplerBorderColor SamplerDescriptor::GetBorderColor() const
    {
#if MTLPP_IS_AVAILABLE_MAC(10_12)
        return SamplerBorderColor([(__bridge MTLSamplerDescriptor*)m_ptr borderColor]);
#else
        return SamplerBorderColor(0);
#endif
    }

    bool SamplerDescriptor::IsNormalizedCoordinates() const
    {
        Validate();
        return [(__bridge MTLSamplerDescriptor*)m_ptr normalizedCoordinates];
    }

    float SamplerDescriptor::GetLodMinClamp() const
    {
        Validate();
        return [(__bridge MTLSamplerDescriptor*)m_ptr lodMinClamp];
    }

    float SamplerDescriptor::GetLodMaxClamp() const
    {
        Validate();
        return [(__bridge MTLSamplerDescriptor*)m_ptr lodMaxClamp];
    }

    CompareFunction SamplerDescriptor::GetCompareFunction() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        return CompareFunction([(__bridge MTLSamplerDescriptor*)m_ptr compareFunction]);
#else
        return CompareFunction(0);
#endif
    }

    ns::String SamplerDescriptor::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLSamplerDescriptor*)m_ptr label] };
    }

    void SamplerDescriptor::SetMinFilter(SamplerMinMagFilter minFilter)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setMinFilter:MTLSamplerMinMagFilter(minFilter)];
    }

    void SamplerDescriptor::SetMagFilter(SamplerMinMagFilter magFilter)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setMagFilter:MTLSamplerMinMagFilter(magFilter)];
    }

    void SamplerDescriptor::SetMipFilter(SamplerMipFilter mipFilter)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setMipFilter:MTLSamplerMipFilter(mipFilter)];
    }

    void SamplerDescriptor::SetMaxAnisotropy(uint32_t maxAnisotropy)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setMaxAnisotropy:maxAnisotropy];
    }

    void SamplerDescriptor::SetSAddressMode(SamplerAddressMode sAddressMode)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setSAddressMode:MTLSamplerAddressMode(sAddressMode)];
    }

    void SamplerDescriptor::SetTAddressMode(SamplerAddressMode tAddressMode)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setTAddressMode:MTLSamplerAddressMode(tAddressMode)];
    }

    void SamplerDescriptor::SetRAddressMode(SamplerAddressMode rAddressMode)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setRAddressMode:MTLSamplerAddressMode(rAddressMode)];
    }

    void SamplerDescriptor::SetBorderColor(SamplerBorderColor borderColor)
    {
#if MTLPP_IS_AVAILABLE_MAC(10_12)
        [(__bridge MTLSamplerDescriptor*)m_ptr setBorderColor:MTLSamplerBorderColor(borderColor)];
#endif
    }

    void SamplerDescriptor::SetNormalizedCoordinates(bool normalizedCoordinates)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setNormalizedCoordinates:normalizedCoordinates];
    }

    void SamplerDescriptor::SetLodMinClamp(float lodMinClamp)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setLodMinClamp:lodMinClamp];
    }

    void SamplerDescriptor::SetLodMaxClamp(float lodMaxClamp)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setLodMaxClamp:lodMaxClamp];
    }

    void SamplerDescriptor::SetCompareFunction(CompareFunction compareFunction)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        [(__bridge MTLSamplerDescriptor*)m_ptr setCompareFunction:MTLCompareFunction(compareFunction)];
#endif
    }

    void SamplerDescriptor::SetLabel(const ns::String& label)
    {
        Validate();
        [(__bridge MTLSamplerDescriptor*)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
    }

    ns::String SamplerState::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLSamplerState>)m_ptr label] };
    }

    Device SamplerState::GetDevice() const
    {
        Validate();
        return ns::Handle { (__bridge void*)[(__bridge id<MTLSamplerState>)m_ptr device] };
    }
}

