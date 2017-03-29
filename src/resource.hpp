/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"

namespace mtlpp
{
    class Heap;

    static const uint32_t ResourceCpuCacheModeShift        = 0;
    static const uint32_t ResourceStorageModeShift         = 4;
    static const uint32_t ResourceHazardTrackingModeShift  = 8;

    enum class PurgeableState
    {
        KeepCurrent = 1,
        NonVolatile = 2,
        Volatile    = 3,
        Empty       = 4,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class CpuCacheMode
    {
        DefaultCache  = 0,
        WriteCombined = 1,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class StorageMode
    {
        Shared                                = 0,
        Managed    MTLPP_AVAILABLE(10_11, NA) = 1,
        Private                               = 2,
        Memoryless MTLPP_AVAILABLE(NA, 10_0)  = 3,
    }
    MTLPP_AVAILABLE(10_11, 9_0);

    enum class ResourceOptions
    {
        CpuCacheModeDefaultCache                                = uint32_t(CpuCacheMode::DefaultCache)  << ResourceCpuCacheModeShift,
        CpuCacheModeWriteCombined                               = uint32_t(CpuCacheMode::WriteCombined) << ResourceCpuCacheModeShift,

        StorageModeShared           MTLPP_AVAILABLE(10_11, 9_0) = uint32_t(StorageMode::Shared)     << ResourceStorageModeShift,
        StorageModeManaged          MTLPP_AVAILABLE(10_11, NA)  = uint32_t(StorageMode::Managed)    << ResourceStorageModeShift,
        StorageModePrivate          MTLPP_AVAILABLE(10_11, 9_0) = uint32_t(StorageMode::Private)    << ResourceStorageModeShift,
        StorageModeMemoryless       MTLPP_AVAILABLE(NA, 10_0)   = uint32_t(StorageMode::Memoryless) << ResourceStorageModeShift,

        HazardTrackingModeUntracked MTLPP_AVAILABLE(NA, 10_0)   = 0x1 << ResourceHazardTrackingModeShift,

        OptionCpuCacheModeDefault                               = CpuCacheModeDefaultCache,
        OptionCpuCacheModeWriteCombined                         = CpuCacheModeWriteCombined,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class Resource : public ns::Object
    {
    public:
        Resource() { }
        Resource(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String   GetLabel() const;
        CpuCacheMode GetCpuCacheMode() const;
        StorageMode  GetStorageMode() const MTLPP_AVAILABLE(10_11, 9_0);
        Heap         GetHeap() const MTLPP_AVAILABLE(NA, 10_0);
        bool         IsAliasable() const MTLPP_AVAILABLE(NA, 10_0);

        void SetLabel(const ns::String& label);

        PurgeableState SetPurgeableState(PurgeableState state);
        void MakeAliasable() const MTLPP_AVAILABLE(NA, 10_0);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
