/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "texture.hpp"
#include <Metal/MTLTexture.h>

namespace mtlpp
{
    TextureDescriptor::TextureDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLTextureDescriptor alloc] init] })
    {
    }

    TextureDescriptor TextureDescriptor::Texture2DDescriptor(PixelFormat pixelFormat, uint32_t width, uint32_t height, bool mipmapped)
    {
        return ns::Handle{ (__bridge void*)[MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormat(pixelFormat)
                                                                                              width:width
                                                                                             height:height
                                                                                          mipmapped:mipmapped] };
    }

    TextureDescriptor TextureDescriptor::TextureCubeDescriptor(PixelFormat pixelFormat, uint32_t size, bool mipmapped)
    {
        return ns::Handle{ (__bridge void*)[MTLTextureDescriptor textureCubeDescriptorWithPixelFormat:MTLPixelFormat(pixelFormat)
                                                                                                 size:size
                                                                                            mipmapped:mipmapped] };
    }

    TextureType TextureDescriptor::GetTextureType() const
    {
        Validate();
        return TextureType([(__bridge MTLTextureDescriptor*)m_ptr textureType]);
    }

    PixelFormat TextureDescriptor::GetPixelFormat() const
    {
        Validate();
        return PixelFormat([(__bridge MTLTextureDescriptor*)m_ptr pixelFormat]);
    }

    uint32_t TextureDescriptor::GetWidth() const
    {
        Validate();
        return uint32_t([(__bridge MTLTextureDescriptor*)m_ptr width]);
    }

    uint32_t TextureDescriptor::GetHeight() const
    {
        Validate();
        return uint32_t([(__bridge MTLTextureDescriptor*)m_ptr height]);
    }

    uint32_t TextureDescriptor::GetDepth() const
    {
        Validate();
        return uint32_t([(__bridge MTLTextureDescriptor*)m_ptr depth]);
    }

    uint32_t TextureDescriptor::GetMipmapLevelCount() const
    {
        Validate();
        return uint32_t([(__bridge MTLTextureDescriptor*)m_ptr mipmapLevelCount]);
    }

    uint32_t TextureDescriptor::GetSampleCount() const
    {
        Validate();
        return uint32_t([(__bridge MTLTextureDescriptor*)m_ptr sampleCount]);
    }

    uint32_t TextureDescriptor::GetArrayLength() const
    {
        Validate();
        return uint32_t([(__bridge MTLTextureDescriptor*)m_ptr arrayLength]);
    }

    ResourceOptions TextureDescriptor::GetResourceOptions() const
    {
        Validate();
        return ResourceOptions([(__bridge MTLTextureDescriptor*)m_ptr resourceOptions]);
    }

    CpuCacheMode TextureDescriptor::GetCpuCacheMode() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        return CpuCacheMode([(__bridge MTLTextureDescriptor*)m_ptr cpuCacheMode]);
#else
        return CpuCacheMode(0);
#endif
    }

    StorageMode TextureDescriptor::GetStorageMode() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        return StorageMode([(__bridge MTLTextureDescriptor*)m_ptr storageMode]);
#else
        return StorageMode(0);
#endif
    }

    TextureUsage TextureDescriptor::GetUsage() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        return TextureUsage([(__bridge MTLTextureDescriptor*)m_ptr usage]);
#else
        return TextureUsage(0);
#endif
    }

    void TextureDescriptor::SetTextureType(TextureType textureType)
    {
        Validate();
        [(__bridge MTLTextureDescriptor*)m_ptr setTextureType:MTLTextureType(textureType)];
    }

    void TextureDescriptor::SetPixelFormat(PixelFormat pixelFormat)
    {
        Validate();
        [(__bridge MTLTextureDescriptor*)m_ptr setPixelFormat:MTLPixelFormat(pixelFormat)];
    }

    void TextureDescriptor::SetWidth(uint32_t width)
    {
        Validate();
        [(__bridge MTLTextureDescriptor*)m_ptr setWidth:width];
    }

    void TextureDescriptor::SetHeight(uint32_t height)
    {
        Validate();
        [(__bridge MTLTextureDescriptor*)m_ptr setHeight:height];
    }

    void TextureDescriptor::SetDepth(uint32_t depth)
    {
        Validate();
        [(__bridge MTLTextureDescriptor*)m_ptr setDepth:depth];
    }

    void TextureDescriptor::SetMipmapLevelCount(uint32_t mipmapLevelCount)
    {
        Validate();
        [(__bridge MTLTextureDescriptor*)m_ptr setMipmapLevelCount:mipmapLevelCount];
    }

    void TextureDescriptor::SetSampleCount(uint32_t sampleCount)
    {
        Validate();
        [(__bridge MTLTextureDescriptor*)m_ptr setSampleCount:sampleCount];
    }

    void TextureDescriptor::SetArrayLength(uint32_t arrayLength)
    {
        Validate();
        [(__bridge MTLTextureDescriptor*)m_ptr setArrayLength:arrayLength];
    }

    void TextureDescriptor::SetResourceOptions(ResourceOptions resourceOptions)
    {
        Validate();
        [(__bridge MTLTextureDescriptor*)m_ptr setResourceOptions:MTLResourceOptions(resourceOptions)];
    }

    void TextureDescriptor::SetCpuCacheMode(CpuCacheMode cpuCacheMode)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        [(__bridge MTLTextureDescriptor*)m_ptr setCpuCacheMode:MTLCPUCacheMode(cpuCacheMode)];
#endif
    }

    void TextureDescriptor::SetStorageMode(StorageMode storageMode)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        [(__bridge MTLTextureDescriptor*)m_ptr setStorageMode:MTLStorageMode(storageMode)];
#endif
    }

    void TextureDescriptor::SetUsage(TextureUsage usage)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        [(__bridge MTLTextureDescriptor*)m_ptr setUsage:MTLTextureUsage(usage)];
#endif
    }

    Resource Texture::GetRootResource() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 8_0)
#   if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return ns::Handle{ nullptr };
#   else
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLTexture>)m_ptr rootResource] };
#   endif
#else
        return ns::Handle{ nullptr };
#endif
    }

    Texture Texture::GetParentTexture() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLTexture>)m_ptr parentTexture] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    uint32_t Texture::GetParentRelativeLevel() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        return uint32_t([(__bridge id<MTLTexture>)m_ptr parentRelativeLevel]);
#else
        return 0;
#endif

    }

    uint32_t Texture::GetParentRelativeSlice() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        return uint32_t([(__bridge id<MTLTexture>)m_ptr parentRelativeSlice]);
#else
        return 0;
#endif

    }

    Buffer Texture::GetBuffer() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 9_0)
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLTexture>)m_ptr buffer] };
#else
        return ns::Handle{ nullptr };
#endif

    }

    uint32_t Texture::GetBufferOffset() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 9_0)
        return uint32_t([(__bridge id<MTLTexture>)m_ptr bufferOffset]);
#else
        return 0;
#endif

    }

    uint32_t Texture::GetBufferBytesPerRow() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 9_0)
        return uint32_t([(__bridge id<MTLTexture>)m_ptr bufferBytesPerRow]);
#else
        return 0;
#endif

    }

    uint32_t Texture::GetIOSurfacePlane() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        return uint32_t([(__bridge id<MTLTexture>)m_ptr iosurfacePlane]);
#else
        return 0;
#endif
    }

    TextureType Texture::GetTextureType() const
    {
        Validate();
        return TextureType([(__bridge id<MTLTexture>)m_ptr textureType]);
    }

    PixelFormat Texture::GetPixelFormat() const
    {
        Validate();
        return PixelFormat([(__bridge id<MTLTexture>)m_ptr pixelFormat]);
    }

    uint32_t Texture::GetWidth() const
    {
        Validate();
        return uint32_t([(__bridge id<MTLTexture>)m_ptr width]);
    }

    uint32_t Texture::GetHeight() const
    {
        Validate();
        return uint32_t([(__bridge id<MTLTexture>)m_ptr height]);
    }

    uint32_t Texture::GetDepth() const
    {
        Validate();
        return uint32_t([(__bridge id<MTLTexture>)m_ptr depth]);
    }

    uint32_t Texture::GetMipmapLevelCount() const
    {
        Validate();
        return uint32_t([(__bridge id<MTLTexture>)m_ptr mipmapLevelCount]);
    }

    uint32_t Texture::GetSampleCount() const
    {
        Validate();
        return uint32_t([(__bridge id<MTLTexture>)m_ptr sampleCount]);
    }

    uint32_t Texture::GetArrayLength() const
    {
        Validate();
        return uint32_t([(__bridge id<MTLTexture>)m_ptr arrayLength]);
    }

    TextureUsage Texture::GetUsage() const
    {
        Validate();
        return TextureUsage([(__bridge id<MTLTexture>)m_ptr usage]);
    }

    bool Texture::IsFrameBufferOnly() const
    {
        Validate();
        return [(__bridge id<MTLTexture>)m_ptr isFramebufferOnly];
    }

    void Texture::GetBytes(void* pixelBytes, uint32_t bytesPerRow, uint32_t bytesPerImage, const Region& fromRegion, uint32_t mipmapLevel, uint32_t slice)
    {
        Validate();
        [(__bridge id<MTLTexture>)m_ptr getBytes:pixelBytes
                                     bytesPerRow:bytesPerRow
                                   bytesPerImage:bytesPerImage
                                      fromRegion:MTLRegionMake3D(fromRegion.Origin.X, fromRegion.Origin.Y, fromRegion.Origin.Z, fromRegion.Size.Width, fromRegion.Size.Height, fromRegion.Size.Depth)
                                     mipmapLevel:mipmapLevel
                                           slice:slice];
    }

    void Texture::Replace(const Region& region, uint32_t mipmapLevel, uint32_t slice, void* pixelBytes, uint32_t bytesPerRow, uint32_t bytesPerImage)
    {
        Validate();
        [(__bridge id<MTLTexture>)m_ptr replaceRegion:MTLRegionMake3D(region.Origin.X, region.Origin.Y, region.Origin.Z, region.Size.Width, region.Size.Height, region.Size.Depth)
                                          mipmapLevel:mipmapLevel
                                                slice:slice
                                            withBytes:pixelBytes
                                          bytesPerRow:bytesPerRow
                                        bytesPerImage:bytesPerImage];
    }

    void Texture::GetBytes(void* pixelBytes, uint32_t bytesPerRow, const Region& fromRegion, uint32_t mipmapLevel)
    {
        Validate();
        [(__bridge id<MTLTexture>)m_ptr getBytes:pixelBytes
                                     bytesPerRow:bytesPerRow
                                      fromRegion:MTLRegionMake3D(fromRegion.Origin.X, fromRegion.Origin.Y, fromRegion.Origin.Z, fromRegion.Size.Width, fromRegion.Size.Height, fromRegion.Size.Depth)
                                     mipmapLevel:mipmapLevel];
    }

    void Texture::Replace(const Region& region, uint32_t mipmapLevel, void* pixelBytes, uint32_t bytesPerRow)
    {
        Validate();
        [(__bridge id<MTLTexture>)m_ptr replaceRegion:MTLRegionMake3D(region.Origin.X, region.Origin.Y, region.Origin.Z, region.Size.Width, region.Size.Height, region.Size.Depth)
                                          mipmapLevel:mipmapLevel
                                            withBytes:pixelBytes
                                          bytesPerRow:bytesPerRow];
    }

    Texture Texture::NewTextureView(PixelFormat pixelFormat)
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLTexture>)m_ptr newTextureViewWithPixelFormat:MTLPixelFormat(pixelFormat)] };
    }

    Texture Texture::NewTextureView(PixelFormat pixelFormat, TextureType textureType, const ns::Range& mipmapLevelRange, const ns::Range& sliceRange)
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLTexture>)m_ptr newTextureViewWithPixelFormat:MTLPixelFormat(pixelFormat)
                                                                                             textureType:MTLTextureType(textureType)
                                                                                                  levels:NSMakeRange(mipmapLevelRange.Location, mipmapLevelRange.Length)
                                                                                                  slices:NSMakeRange(sliceRange.Location, sliceRange.Length)] };
    }
}
