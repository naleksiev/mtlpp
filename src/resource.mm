/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "resource.hpp"
#include "heap.hpp"
#include <Metal/MTLResource.h>

namespace mtlpp
{
    ns::String Resource::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLResource>)m_ptr label] };
    }

    CpuCacheMode Resource::GetCpuCacheMode() const
    {
        Validate();
        return CpuCacheMode([(__bridge id<MTLResource>)m_ptr cpuCacheMode]);
    }

    StorageMode Resource::GetStorageMode() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        return StorageMode([(__bridge id<MTLResource>)m_ptr storageMode]);
#else
        return StorageMode(0);
#endif
    }

    Heap Resource::GetHeap() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLResource>)m_ptr heap] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    bool Resource::IsAliasable() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        return [(__bridge id<MTLResource>)m_ptr isAliasable];
#else
        return false;
#endif
    }

    void Resource::SetLabel(const ns::String& label)
    {
        Validate();
        [(__bridge id<MTLResource>)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
    }

    PurgeableState Resource::SetPurgeableState(PurgeableState state)
    {
        Validate();
        return PurgeableState([(__bridge id<MTLResource>)m_ptr setPurgeableState:MTLPurgeableState(state)]);
    }

    void Resource::MakeAliasable() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        [(__bridge id<MTLResource>)m_ptr makeAliasable];
#endif
    }
}
