/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"
#include "device.hpp"
#include "resource.hpp"
#include "buffer.hpp"
#include "texture.hpp"
#include "types.hpp"

namespace mtlpp
{
    class HeapDescriptor : public ns::Object
    {
    public:
        HeapDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        uint32_t     GetSize() const;
        StorageMode  GetStorageMode() const;
        CpuCacheMode GetCpuCacheMode() const;

        void SetSize(uint32_t size) const;
        void SetStorageMode(StorageMode storageMode) const;
        void SetCpuCacheMode(CpuCacheMode cpuCacheMode) const;
    }
    MTLPP_AVAILABLE(NA, 10_0);

    class Heap : public ns::Object
    {
    public:
        Heap(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String   GetLabel() const;
        Device       GetDevice() const;
        StorageMode  GetStorageMode() const;
        CpuCacheMode GetCpuCacheMode() const;
        uint32_t     GetSize() const;
        uint32_t     GetUsedSize() const;

        void SetLabel(const ns::String& label);

        uint32_t MaxAvailableSizeWithAlignment(uint32_t alignment);
        Buffer NewBuffer(uint32_t length, ResourceOptions options);
        Texture NewTexture(const TextureDescriptor& desc);
        PurgeableState SetPurgeableState(PurgeableState state);
    }
    MTLPP_AVAILABLE(NA, 10_0);
}
