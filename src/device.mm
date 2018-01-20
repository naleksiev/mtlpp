/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "device.hpp"
#include "buffer.hpp"
#include "command_queue.hpp"
#include "compute_pipeline.hpp"
#include "depth_stencil.hpp"
#include "render_pipeline.hpp"
#include "sampler.hpp"
#include "texture.hpp"
#include "heap.hpp"
#include <Metal/MTLDevice.h>

namespace mtlpp
{
    CompileOptions::CompileOptions() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLCompileOptions alloc] init] })
    {
    }

    Device Device::CreateSystemDefaultDevice()
    {
        return ns::Handle{ (__bridge void*)MTLCreateSystemDefaultDevice() };
    }

    ns::Array<Device> Device::CopyAllDevices()
    {
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        return ns::Handle{ (__bridge void*)MTLCopyAllDevices() };
#else
        return ns::Handle{ nullptr };
#endif
    }

    ns::String Device::GetName() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr name] };
    }

    Size Device::GetMaxThreadsPerThreadgroup() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        MTLSize mtlSize = [(__bridge id<MTLDevice>)m_ptr maxThreadsPerThreadgroup];
        return Size(uint32_t(mtlSize.width), uint32_t(mtlSize.height), uint32_t(mtlSize.depth));
#else
        return Size(0, 0, 0);
#endif
    }

    bool Device::IsLowPower() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        return [(__bridge id<MTLDevice>)m_ptr isLowPower];
#else
        return false;
#endif
    }

    bool Device::IsHeadless() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        return [(__bridge id<MTLDevice>)m_ptr isHeadless];
#else
        return false;
#endif
    }

    uint64_t Device::GetRecommendedMaxWorkingSetSize() const
    {
#if MTLPP_IS_AVAILABLE_MAC(10_12)
        return [(__bridge id<MTLDevice>)m_ptr recommendedMaxWorkingSetSize];
#else
        return 0;
#endif
    }

    bool Device::IsDepth24Stencil8PixelFormatSupported() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        return [(__bridge id<MTLDevice>)m_ptr isDepth24Stencil8PixelFormatSupported];
#else
        return true;
#endif
    }

    CommandQueue Device::NewCommandQueue()
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newCommandQueue] };
    }

    CommandQueue Device::NewCommandQueue(uint32_t maxCommandBufferCount)
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newCommandQueueWithMaxCommandBufferCount:maxCommandBufferCount] };
    }

    SizeAndAlign Device::HeapTextureSizeAndAlign(const TextureDescriptor& desc)
    {
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        MTLSizeAndAlign mtlSizeAndAlign = [(__bridge id<MTLDevice>)m_ptr heapTextureSizeAndAlignWithDescriptor:(__bridge MTLTextureDescriptor*)desc.GetPtr()];
        return SizeAndAlign{ uint32_t(mtlSizeAndAlign.size), uint32_t(mtlSizeAndAlign.align) };
#else
        return SizeAndAlign{0, 0};
#endif
    }

    SizeAndAlign Device::HeapBufferSizeAndAlign(uint32_t length, ResourceOptions options)
    {
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        MTLSizeAndAlign mtlSizeAndAlign = [(__bridge id<MTLDevice>)m_ptr heapBufferSizeAndAlignWithLength:length options:MTLResourceOptions(options)];
        return SizeAndAlign{ uint32_t(mtlSizeAndAlign.size), uint32_t(mtlSizeAndAlign.align) };
#else
        return SizeAndAlign{0, 0};
#endif
    }

    Heap Device::NewHeap(const HeapDescriptor& descriptor)
    {
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newHeapWithDescriptor:(__bridge MTLHeapDescriptor*)descriptor.GetPtr()] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    Buffer Device::NewBuffer(uint32_t length, ResourceOptions options)
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newBufferWithLength:length options:MTLResourceOptions(options)] };
    }

    Buffer Device::NewBuffer(const void* pointer, uint32_t length, ResourceOptions options)
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newBufferWithBytes:pointer length:length options:MTLResourceOptions(options)] };
    }


    Buffer Device::NewBuffer(void* pointer, uint32_t length, ResourceOptions options, std::function<void (void* pointer, uint32_t length)> deallocator)
    {
        Validate();
        return ns::Handle{
            (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newBufferWithBytesNoCopy:pointer
                                                                             length:length
                                                                            options:MTLResourceOptions(options)
                                                                        deallocator:^(void* pointer, NSUInteger length) { deallocator(pointer, uint32_t(length)); }]
        };
    }

    DepthStencilState Device::NewDepthStencilState(const DepthStencilDescriptor& descriptor)
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newDepthStencilStateWithDescriptor:(__bridge MTLDepthStencilDescriptor*)descriptor.GetPtr()] };
    }

    Texture Device::NewTexture(const TextureDescriptor& descriptor)
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newTextureWithDescriptor:(__bridge MTLTextureDescriptor*)descriptor.GetPtr()] };
    }

    //- (id <MTLTexture>)newTextureWithDescriptor:(MTLTextureDescriptor *)descriptor iosurface:(IOSurfaceRef)iosurface plane:(NSUInteger)plane NS_AVAILABLE_MAC(10_11);
    SamplerState Device::NewSamplerState(const SamplerDescriptor& descriptor)
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newSamplerStateWithDescriptor:(__bridge MTLSamplerDescriptor*)descriptor.GetPtr()] };
    }

    Library Device::NewDefaultLibrary()
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newDefaultLibrary] };
    }

    Library Device::NewLibrary(const ns::String& filepath, ns::Error* error)
    {
        Validate();

        // Error
        NSError* nsError = NULL;
        NSError** nsErrorPtr = error ? &nsError : nullptr;

        id<MTLLibrary> library = [(__bridge id<MTLDevice>)m_ptr newLibraryWithFile:(__bridge NSString*)filepath.GetPtr() error:nsErrorPtr];

        // Error update
        if (error && nsError){
            *error = ns::Handle{ (__bridge void*)nsError };
        }  

        return ns::Handle{ (__bridge void*)library };
    }

    Library Device::NewLibrary(const char* source, const CompileOptions& options, ns::Error* error)
    {
        Validate();
        NSString* nsSource = [NSString stringWithUTF8String:source];
        
        // Error
        NSError* nsError = NULL;
        NSError** nsErrorPtr = error ? &nsError : nullptr;

        id<MTLLibrary> library = [(__bridge id<MTLDevice>)m_ptr newLibraryWithSource:nsSource
                                                                             options:(__bridge MTLCompileOptions*)options.GetPtr()
                                                                               error:nsErrorPtr];

        // Error update
        if (error && nsError){
            *error = ns::Handle{ (__bridge void*)nsError };
        }                            

        return ns::Handle{ (__bridge void*)library };
    }

    void Device::NewLibrary(const char* source, const CompileOptions& options, std::function<void(const Library&, const ns::Error&)> completionHandler)
    {
        Validate();
        NSString* nsSource = [NSString stringWithUTF8String:source];
        [(__bridge id<MTLDevice>)m_ptr newLibraryWithSource:nsSource
                                                    options:(__bridge MTLCompileOptions*)options.GetPtr()
                                          completionHandler:^(id <MTLLibrary> library, NSError * error) {
                                                completionHandler(
                                                    ns::Handle{ (__bridge void*)library },
                                                    ns::Handle{ (__bridge void*)error });
                                          }];
    }

    RenderPipelineState Device::NewRenderPipelineState(const RenderPipelineDescriptor& descriptor, ns::Error* error)
    {
        Validate();

        // Error
        NSError* nsError = NULL;
        NSError** nsErrorPtr = error ? &nsError : nullptr;

        id<MTLRenderPipelineState> renderPipelineState = [(__bridge id<MTLDevice>)m_ptr newRenderPipelineStateWithDescriptor:(__bridge MTLRenderPipelineDescriptor*)descriptor.GetPtr()
                                                                                                                       error:nsErrorPtr];

        // Error update
        if (error && nsError){
            *error = ns::Handle{ (__bridge void*)nsError };
        }

        return ns::Handle{ (__bridge void*)renderPipelineState };
    }

    RenderPipelineState Device::NewRenderPipelineState(const RenderPipelineDescriptor& descriptor, PipelineOption options, RenderPipelineReflection* outReflection, ns::Error* error)
    {
        Validate();
        
        // Error
        NSError* nsError = NULL;
        NSError** nsErrorPtr = error ? &nsError : nullptr;

        // Reflection
        MTLRenderPipelineReflection* reflection = NULL;
        MTLRenderPipelineReflection** reflectionPtr = outReflection ? &reflection : nullptr;

        id<MTLRenderPipelineState> renderPipelineState = [(__bridge id<MTLDevice>)m_ptr newRenderPipelineStateWithDescriptor:(__bridge MTLRenderPipelineDescriptor*)descriptor.GetPtr()
                                                                                                                     options:MTLPipelineOption(options)
                                                                                                                  reflection:reflectionPtr
                                                                                                                       error:nsErrorPtr];
        // Error update
        if (error && nsError){
            *error = ns::Handle{ (__bridge void*)nsError };
        }

        // Reflection update
        if(outReflection && reflection){
            *outReflection = ns::Handle{ (__bridge void*)reflection };
        }

        return ns::Handle{ (__bridge void*)renderPipelineState };
    }

    void Device::NewRenderPipelineState(const RenderPipelineDescriptor& descriptor, std::function<void(const RenderPipelineState&, const ns::Error&)> completionHandler)
    {
        Validate();
        [(__bridge id<MTLDevice>)m_ptr newRenderPipelineStateWithDescriptor:(__bridge MTLRenderPipelineDescriptor*)descriptor.GetPtr()
                                                          completionHandler:^(id <MTLRenderPipelineState> renderPipelineState, NSError * error) {
                                                              completionHandler(
                                                                  ns::Handle{ (__bridge void*)renderPipelineState },
                                                                  ns::Handle{ (__bridge void*)error }
                                                              );
                                                          }];
    }

    void Device::NewRenderPipelineState(const RenderPipelineDescriptor& descriptor, PipelineOption options, std::function<void(const RenderPipelineState&, const RenderPipelineReflection&, const ns::Error&)> completionHandler)
    {
        Validate();
        [(__bridge id<MTLDevice>)m_ptr newRenderPipelineStateWithDescriptor:(__bridge MTLRenderPipelineDescriptor*)descriptor.GetPtr()
                                                                    options:MTLPipelineOption(options)
                                                          completionHandler:^(id <MTLRenderPipelineState> renderPipelineState, MTLRenderPipelineReflection * reflection, NSError * error) {
                                                              completionHandler(
                                                                  ns::Handle{ (__bridge void*)renderPipelineState },
                                                                  ns::Handle{ (__bridge void*)reflection },
                                                                  ns::Handle{ (__bridge void*)error }
                                                              );
                                                          }];
    }

    ComputePipelineState Device::NewComputePipelineState(const Function& computeFunction, ns::Error* error)
    {
        Validate();
        
        // Error
        NSError* nsError = NULL;
        NSError** nsErrorPtr = error ? &nsError : nullptr;

        id<MTLComputePipelineState> state = [(__bridge id<MTLDevice>)m_ptr newComputePipelineStateWithFunction:(__bridge id<MTLFunction>)computeFunction.GetPtr()
                                                                                                         error:nsErrorPtr];

        // Error update
        if (error && nsError){
            *error = ns::Handle{ (__bridge void*)nsError };
        }

        return ns::Handle{ (__bridge void*)state };
    }

    ComputePipelineState Device::NewComputePipelineState(const Function& computeFunction, PipelineOption options, ComputePipelineReflection& outReflection, ns::Error* error)
    {
        Validate();
        return ns::Handle{ nullptr };
    }

    void Device::NewComputePipelineState(const Function& computeFunction, std::function<void(const ComputePipelineState&, const ns::Error&)> completionHandler)
    {
        Validate();
        [(__bridge id<MTLDevice>)m_ptr newComputePipelineStateWithFunction:(__bridge id<MTLFunction>)computeFunction.GetPtr()
                                                         completionHandler:^(id <MTLComputePipelineState> computePipelineState, NSError * error) {
                                                             completionHandler(
                                                                 ns::Handle{ (__bridge void*)computePipelineState },
                                                                 ns::Handle{ (__bridge void*)error }
                                                             );
                                                         }];
    }

    void Device::NewComputePipelineState(const Function& computeFunction, PipelineOption options, std::function<void(const ComputePipelineState&, const ComputePipelineReflection&, const ns::Error&)> completionHandler)
    {
        Validate();
        [(__bridge id<MTLDevice>)m_ptr newComputePipelineStateWithFunction:(__bridge id<MTLFunction>)computeFunction.GetPtr()
                                                                   options:MTLPipelineOption(options)
                                                         completionHandler:^(id <MTLComputePipelineState> computePipelineState, MTLComputePipelineReflection * reflection, NSError * error) {
                                                             completionHandler(
                                                                 ns::Handle{ (__bridge void*)computePipelineState },
                                                                 ns::Handle{ (__bridge void*)reflection },
                                                                 ns::Handle{ (__bridge void*)error }
                                                             );
                                                         }];
    }

    ComputePipelineState Device::NewComputePipelineState(const ComputePipelineDescriptor& descriptor, PipelineOption options, ComputePipelineReflection* outReflection, ns::Error* error)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        // Error
        NSError* nsError = NULL;
        NSError** nsErrorPtr = error ? &nsError : nullptr;

        // Reflection
        MTLComputePipelineReflection* reflection = NULL;
        MTLComputePipelineReflection** reflectionPtr = outReflection ? &reflection : nullptr;

        id<MTLComputePipelineState> state = [(__bridge id<MTLDevice>)m_ptr newComputePipelineStateWithDescriptor:(__bridge MTLComputePipelineDescriptor*)descriptor.GetPtr()
                                                                                                         options:MTLPipelineOption(options)
                                                                                                      reflection:reflectionPtr
                                                                                                           error:nsErrorPtr];

        // Error update
        if (error && nsError){
            *error = ns::Handle{ (__bridge void*)nsError };
        }

        // Reflection update
        if(outReflection && reflection){
            *outReflection = ns::Handle{ (__bridge void*)reflection };
        }

        return ns::Handle{ (__bridge void*)state };
#else
        return ns::Handle{ nullptr };
#endif
    }

    void Device::NewComputePipelineState(const ComputePipelineDescriptor& descriptor, PipelineOption options, std::function<void(const ComputePipelineState&, const ComputePipelineReflection&, const ns::Error&)> completionHandler)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        [(__bridge id<MTLDevice>)m_ptr newComputePipelineStateWithDescriptor:(__bridge MTLComputePipelineDescriptor*)descriptor.GetPtr()
                                                                     options:MTLPipelineOption(options)
                                                         completionHandler:^(id <MTLComputePipelineState> computePipelineState, MTLComputePipelineReflection * reflection, NSError * error)
                                                                    {
                                                                        completionHandler(
                                                                            ns::Handle{ (__bridge void*)computePipelineState },
                                                                            ns::Handle{ (__bridge void*)reflection },
                                                                            ns::Handle{ (__bridge void*)error });
                                                                    }];
#endif
    }

    Fence Device::NewFence()
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLDevice>)m_ptr newFence] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    bool Device::SupportsFeatureSet(FeatureSet featureSet) const
    {
        Validate();
        return [(__bridge id<MTLDevice>)m_ptr supportsFeatureSet:MTLFeatureSet(featureSet)];
    }

    bool Device::SupportsTextureSampleCount(uint32_t sampleCount) const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        return [(__bridge id<MTLDevice>)m_ptr supportsTextureSampleCount:sampleCount];
#else
        return true;
#endif
    }
}
