/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "command_encoder.hpp"
#include "buffer.hpp"
#include "texture.hpp"
#include "fence.hpp"

namespace mtlpp
{
    enum class BlitOption
    {
        None                                             = 0,
        DepthFromDepthStencil                            = 1 << 0,
        StencilFromDepthStencil                          = 1 << 1,
        RowLinearPVRTC          MTLPP_AVAILABLE_IOS(9_0) = 1 << 2,
    }
    MTLPP_AVAILABLE(10_11, 9_0);

    class BlitCommandEncoder : public CommandEncoder
    {
    public:
        BlitCommandEncoder() { }
        BlitCommandEncoder(const ns::Handle& handle) : CommandEncoder(handle) { }

        void Synchronize(const Resource& resource) MTLPP_AVAILABLE_MAC(10_11);
        void Synchronize(const Texture& texture, uint32_t slice, uint32_t level) MTLPP_AVAILABLE_MAC(10_11);
        void Copy(const Texture& sourceTexture, uint32_t sourceSlice, uint32_t sourceLevel, const Origin& sourceOrigin, const Size& sourceSize, const Texture& destinationTexture, uint32_t destinationSlice, uint32_t destinationLevel, const Origin& destinationOrigin);
        void Copy(const Buffer& sourceBuffer, uint32_t sourceOffset, uint32_t sourceBytesPerRow, uint32_t sourceBytesPerImage, const Size& sourceSize, const Texture& destinationTexture, uint32_t destinationSlice, uint32_t destinationLevel, const Origin& destinationOrigin);
        void Copy(const Buffer& sourceBuffer, uint32_t sourceOffset, uint32_t sourceBytesPerRow, uint32_t sourceBytesPerImage, const Size& sourceSize, const Texture& destinationTexture, uint32_t destinationSlice, uint32_t destinationLevel, const Origin& destinationOrigin, BlitOption options);
        void Copy(const Texture& sourceTexture, uint32_t sourceSlice, uint32_t sourceLevel, const Origin& sourceOrigin, const Size& sourceSize, const Buffer& destinationBuffer, uint32_t destinationOffset, uint32_t destinationBytesPerRow, uint32_t destinationBytesPerImage);
        void Copy(const Texture& sourceTexture, uint32_t sourceSlice, uint32_t sourceLevel, const Origin& sourceOrigin, const Size& sourceSize, const Buffer& destinationBuffer, uint32_t destinationOffset, uint32_t destinationBytesPerRow, uint32_t destinationBytesPerImage, BlitOption options);
        void Copy(const Buffer& sourceBuffer, uint32_t soruceOffset, const Buffer& destinationBuffer, uint32_t destinationOffset, uint32_t size);
        void GenerateMipmaps(const Texture& texture);
        void Fill(const Buffer& buffer, const ns::Range& range, uint8_t value);
        void UpdateFence(const Fence& fence) MTLPP_AVAILABLE_IOS(10_0);
        void WaitForFence(const Fence& fence) MTLPP_AVAILABLE_IOS(10_0);
    };
}
