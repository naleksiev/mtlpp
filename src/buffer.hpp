/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "pixel_format.hpp"
#include "resource.hpp"

namespace mtlpp
{
    class Texture;
    class TextureDescriptor;

    class Buffer : public Resource
    {
    public:
        Buffer() { }
        Buffer(const ns::Handle& handle) : Resource(handle) { }

        uint32_t GetLength() const;
        void*    GetContents();
        void     DidModify(const ns::Range& range) MTLPP_AVAILABLE_MAC(10_11);
        Texture  NewTexture(const TextureDescriptor& descriptor, uint32_t offset, uint32_t bytesPerRow) MTLPP_AVAILABLE_IOS(8_0);
        void     AddDebugMarker(const ns::String& marker, const ns::Range& range) MTLPP_AVAILABLE(10_12, 10_0);
        void     RemoveAllDebugMarkers() MTLPP_AVAILABLE(10_12, 10_0);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
