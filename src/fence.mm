/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "fence.hpp"
#if MTLPP_IS_AVAILABLE_IOS(10_0)
#   include <Metal/MTLFence.h>
#endif

namespace mtlpp
{
    Texture Fence::GetDevice() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLFence>)m_ptr device] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    ns::String Fence::GetLabel() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLFence>)m_ptr label] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    void Fence::SetLabel(const ns::String& label)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        [(__bridge id<MTLFence>)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
#endif
    }
}
