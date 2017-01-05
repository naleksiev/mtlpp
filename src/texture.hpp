/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "resource.hpp"
#include "buffer.hpp"
#include "types.hpp"

namespace mtlpp
{
    enum class TextureType
    {
        Texture1D                                       = 0,
        Texture1DArray                                  = 1,
        Texture2D                                       = 2,
        Texture2DArray                                  = 3,
        Texture2DMultisample                            = 4,
        TextureCube                                     = 5,
        TextureCubeArray     MTLPP_AVAILABLE_MAC(10_11) = 6,
        Texture3D                                       = 7,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class TextureUsage
    {
        Unknown         = 0x0000,
        ShaderRead      = 0x0001,
        ShaderWrite     = 0x0002,
        RenderTarget    = 0x0004,
        PixelFormatView = 0x0010,
    }
    MTLPP_AVAILABLE(10_11, 9_0);


    class TextureDescriptor : public ns::Object
    {
    public:
        TextureDescriptor();
        TextureDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        static TextureDescriptor Texture2DDescriptor(PixelFormat pixelFormat, uint32_t width, uint32_t height, bool mipmapped);
        static TextureDescriptor TextureCubeDescriptor(PixelFormat pixelFormat, uint32_t size, bool mipmapped);

        TextureType     GetTextureType() const;
        PixelFormat     GetPixelFormat() const;
        uint32_t        GetWidth() const;
        uint32_t        GetHeight() const;
        uint32_t        GetDepth() const;
        uint32_t        GetMipmapLevelCount() const;
        uint32_t        GetSampleCount() const;
        uint32_t        GetArrayLength() const;
        ResourceOptions GetResourceOptions() const;
        CpuCacheMode    GetCpuCacheMode() const MTLPP_AVAILABLE(10_11, 9_0);
        StorageMode     GetStorageMode() const MTLPP_AVAILABLE(10_11, 9_0);
        TextureUsage    GetUsage() const MTLPP_AVAILABLE(10_11, 9_0);

        void SetTextureType(TextureType textureType);
        void SetPixelFormat(PixelFormat pixelFormat);
        void SetWidth(uint32_t width);
        void SetHeight(uint32_t height);
        void SetDepth(uint32_t depth);
        void SetMipmapLevelCount(uint32_t mipmapLevelCount);
        void SetSampleCount(uint32_t sampleCount);
        void SetArrayLength(uint32_t arrayLength);
        void SetResourceOptions(ResourceOptions resourceOptions);
        void SetCpuCacheMode(CpuCacheMode cpuCacheMode) MTLPP_AVAILABLE(10_11, 9_0);
        void SetStorageMode(StorageMode storageMode) MTLPP_AVAILABLE(10_11, 9_0);
        void SetUsage(TextureUsage usage) MTLPP_AVAILABLE(10_11, 9_0);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class Texture : public Resource
    {
    public:
        Texture() { }
        Texture(const ns::Handle& handle) : Resource(handle) { }

        Resource     GetRootResource() const MTLPP_DEPRECATED(10_11, 10_12, 8_0, 10_0);
        Texture      GetParentTexture() const MTLPP_AVAILABLE(10_11, 9_0);
        uint32_t     GetParentRelativeLevel() const MTLPP_AVAILABLE(10_11, 9_0);
        uint32_t     GetParentRelativeSlice() const MTLPP_AVAILABLE(10_11, 9_0);
        Buffer       GetBuffer() const MTLPP_AVAILABLE(10_12, 9_0);
        uint32_t     GetBufferOffset() const MTLPP_AVAILABLE(10_12, 9_0);
        uint32_t     GetBufferBytesPerRow() const MTLPP_AVAILABLE(10_12, 9_0);
        //IOSurfaceRef GetIOSurface() const;
        uint32_t     GetIOSurfacePlane() const MTLPP_AVAILABLE_MAC(10_11);
        TextureType  GetTextureType() const;
        PixelFormat  GetPixelFormat() const;
        uint32_t     GetWidth() const;
        uint32_t     GetHeight() const;
        uint32_t     GetDepth() const;
        uint32_t     GetMipmapLevelCount() const;
        uint32_t     GetSampleCount() const;
        uint32_t     GetArrayLength() const;
        TextureUsage GetUsage() const;
        bool         IsFrameBufferOnly() const;

        void GetBytes(void* pixelBytes, uint32_t bytesPerRow, uint32_t bytesPerImage, const Region& fromRegion, uint32_t mipmapLevel, uint32_t slice);
        void Replace(const Region& region, uint32_t mipmapLevel, uint32_t slice, void* pixelBytes, uint32_t bytesPerRow, uint32_t bytesPerImage);
        void GetBytes(void* pixelBytes, uint32_t bytesPerRow, const Region& fromRegion, uint32_t mipmapLevel);
        void Replace(const Region& region, uint32_t mipmapLevel, void* pixelBytes, uint32_t bytesPerRow);
        Texture NewTextureView(PixelFormat pixelFormat);
        Texture NewTextureView(PixelFormat pixelFormat, TextureType textureType, const ns::Range& mipmapLevelRange, const ns::Range& sliceRange);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
