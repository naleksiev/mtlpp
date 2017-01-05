/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "types.hpp"
#include "pixel_format.hpp"
#include "resource.hpp"
#include "library.hpp"

namespace mtlpp
{
    class CommandQueue;
    class Device;
    class Buffer;
    class DepthStencilState;
    class Function;
    class Library;
    class Texture;
    class SamplerState;
    class RenderPipelineState;
    class ComputePipelineState;
    class Heap;
    class Fence;

    class SamplerDescriptor;
    class RenderPipelineColorAttachmentDescriptor;
    class DepthStencilDescriptor;
    class TextureDescriptor;
    class CompileOptions;
    class RenderPipelineDescriptor;
    class RenderPassDescriptor;
    class RenderPipelineReflection;
    class ComputePipelineDescriptor;
    class ComputePipelineReflection;
    class CommandQueueDescriptor;
    class HeapDescriptor;

    enum class FeatureSet
    {
        iOS_GPUFamily1_v1         MTLPP_AVAILABLE_IOS(8_0)   = 0,
        iOS_GPUFamily2_v1         MTLPP_AVAILABLE_IOS(8_0)   = 1,

        iOS_GPUFamily1_v2         MTLPP_AVAILABLE_IOS(8_0)   = 2,
        iOS_GPUFamily2_v2         MTLPP_AVAILABLE_IOS(8_0)   = 3,
        iOS_GPUFamily3_v1         MTLPP_AVAILABLE_IOS(9_0)   = 4,

        iOS_GPUFamily1_v3         MTLPP_AVAILABLE_IOS(10_0)  = 5,
        iOS_GPUFamily2_v3         MTLPP_AVAILABLE_IOS(10_0)  = 6,
        iOS_GPUFamily3_v2         MTLPP_AVAILABLE_IOS(10_0)  = 7,

        OSX_GPUFamily1_v1         MTLPP_AVAILABLE_MAC(8_0)   = 10000,

        OSX_GPUFamily1_v2         MTLPP_AVAILABLE_MAC(10_12) = 10001,
        OSX_ReadWriteTextureTier2 MTLPP_AVAILABLE_MAC(10_12) = 10002,

        tvOS_GPUFamily1_v1        MTLPP_AVAILABLE_TVOS(9_0)  = 30000,

        tvOS_GPUFamily1_v2        MTLPP_AVAILABLE_TVOS(10_0) = 30001,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class PipelineOption
    {
        None           = 0,
        ArgumentInfo   = 1 << 0,
        BufferTypeInfo = 1 << 1,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    struct SizeAndAlign
    {
        uint32_t Size;
        uint32_t Align;
    };

    class Device : public ns::Object
    {
    public:
        Device() { }
        Device(const ns::Handle& handle) : ns::Object(handle) { }

        static Device CreateSystemDefaultDevice() MTLPP_AVAILABLE(10_11, 8_0);
        static ns::Array<Device> CopyAllDevices() MTLPP_AVAILABLE(10_11, NA);

        ns::String GetName() const;
        Size       GetMaxThreadsPerThreadgroup() const MTLPP_AVAILABLE(10_11, 9_0);
        bool       IsLowPower() const MTLPP_AVAILABLE_MAC(10_11);
        bool       IsHeadless() const MTLPP_AVAILABLE_MAC(10_11);
        uint64_t   GetRecommendedMaxWorkingSetSize() const MTLPP_AVAILABLE_MAC(10_12);
        bool       IsDepth24Stencil8PixelFormatSupported() const MTLPP_AVAILABLE_MAC(10_11);

        CommandQueue NewCommandQueue();
        CommandQueue NewCommandQueue(uint32_t maxCommandBufferCount);
        SizeAndAlign HeapTextureSizeAndAlign(const TextureDescriptor& desc) MTLPP_AVAILABLE(NA, 10_0);
        SizeAndAlign HeapBufferSizeAndAlign(uint32_t length, ResourceOptions options) MTLPP_AVAILABLE(NA, 10_0);
        Heap NewHeap(const HeapDescriptor& descriptor) MTLPP_AVAILABLE(NA, 10_0);
        Buffer NewBuffer(uint32_t length, ResourceOptions options);
        Buffer NewBuffer(const void* pointer, uint32_t length, ResourceOptions options);
        Buffer NewBuffer(void* pointer, uint32_t length, ResourceOptions options, std::function<void (void* pointer, uint32_t length)> deallocator);
        DepthStencilState NewDepthStencilState(const DepthStencilDescriptor& descriptor);
        Texture NewTexture(const TextureDescriptor& descriptor);
        //- (id <MTLTexture>)newTextureWithDescriptor:(MTLTextureDescriptor *)descriptor iosurface:(IOSurfaceRef)iosurface plane:(NSUInteger)plane NS_AVAILABLE_MAC(10_11);
        SamplerState NewSamplerState(const SamplerDescriptor& descriptor);
        Library NewDefaultLibrary();
        //- (nullable id <MTLLibrary>)newDefaultLibraryWithBundle:(NSBundle *)bundle error:(__autoreleasing NSError **)error NS_AVAILABLE(10_12, 10_0);
        Library NewLibrary(const ns::String& filepath, ns::Error* error);
        Library NewLibrary(const char* source, const CompileOptions& options, ns::Error* error);
        void NewLibrary(const char* source, const CompileOptions& options, std::function<void(const Library&, const ns::Error&)> completionHandler);
        RenderPipelineState NewRenderPipelineState(const RenderPipelineDescriptor& descriptor, ns::Error* error);
        RenderPipelineState NewRenderPipelineState(const RenderPipelineDescriptor& descriptor, PipelineOption options, RenderPipelineReflection* outReflection, ns::Error* error);
        void NewRenderPipelineState(const RenderPipelineDescriptor& descriptor, std::function<void(const RenderPipelineState&, const ns::Error&)> completionHandler);
        void NewRenderPipelineState(const RenderPipelineDescriptor& descriptor, PipelineOption options, std::function<void(const RenderPipelineState&, const RenderPipelineReflection&, const ns::Error&)> completionHandler);
        ComputePipelineState NewComputePipelineState(const Function& computeFunction, ns::Error* error);
        ComputePipelineState NewComputePipelineState(const Function& computeFunction, PipelineOption options, ComputePipelineReflection& outReflection, ns::Error* error);
        void NewComputePipelineState(const Function& computeFunction, std::function<void(const ComputePipelineState&, const ns::Error&)> completionHandler);
        void NewComputePipelineState(const Function& computeFunction, PipelineOption options, std::function<void(const ComputePipelineState&, const ComputePipelineReflection&, const ns::Error&)> completionHandler);
        ComputePipelineState NewComputePipelineState(const ComputePipelineDescriptor& descriptor, PipelineOption options, ComputePipelineReflection* outReflection, ns::Error* error);
        void NewComputePipelineState(const ComputePipelineDescriptor& descriptor, PipelineOption options, std::function<void(const ComputePipelineState&, const ComputePipelineReflection&, const ns::Error&)> completionHandler) MTLPP_AVAILABLE(10_11, 9_0);
        Fence NewFence() MTLPP_AVAILABLE(NA, 10_0);
        bool SupportsFeatureSet(FeatureSet featureSet) const;
        bool SupportsTextureSampleCount(uint32_t sampleCount) const MTLPP_AVAILABLE(10_11, 9_0);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
