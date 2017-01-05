/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "compute_command_encoder.hpp"
#include "buffer.hpp"
#include "compute_pipeline.hpp"
#include "sampler.hpp"
#include <Metal/MTLComputeCommandEncoder.h>

namespace mtlpp
{
    void ComputeCommandEncoder::SetComputePipelineState(const ComputePipelineState& state)
    {
        Validate();
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setComputePipelineState:(__bridge id<MTLComputePipelineState>)state.GetPtr()];
    }

    void ComputeCommandEncoder::SetBytes(const void* data, uint32_t length, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setBytes:data length:length atIndex:index];
    }

    void ComputeCommandEncoder::SetBuffer(const Buffer& buffer, uint32_t offset, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setBuffer:(__bridge id<MTLBuffer>)buffer.GetPtr() offset:offset atIndex:index];
    }

    void ComputeCommandEncoder::SetBufferOffset(uint32_t offset, uint32_t index)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 8_3)
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setBufferOffset:offset atIndex:index];
#endif
    }

    void ComputeCommandEncoder::SetBuffers(const Buffer* buffers, const uint32_t* offsets, const ns::Range& range)
    {
        Validate();

        const uint32_t maxBuffers = 32;
        assert(range.Length <= maxBuffers);

        id<MTLBuffer> mtlBuffers[maxBuffers];
        NSUInteger    nsOffsets[maxBuffers];
        for (uint32_t i=0; i<range.Length; i++)
        {
            mtlBuffers[i] = (__bridge id<MTLBuffer>)buffers[i].GetPtr();
            nsOffsets[i] = offsets[i];
        }

        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setBuffers:mtlBuffers
                                                         offsets:nsOffsets
                                                       withRange:NSMakeRange(range.Location, range.Length)];
    }

    void ComputeCommandEncoder::SetTexture(const Texture& texture, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setTexture:(__bridge id<MTLTexture>)texture.GetPtr() atIndex:index];
    }

    void ComputeCommandEncoder::SetTextures(const Texture* textures, const ns::Range& range)
    {
        Validate();

        const uint32_t maxTextures = 32;
        assert(range.Length <= maxTextures);

        id<MTLTexture> mtlTextures[maxTextures];
        for (uint32_t i=0; i<range.Length; i++)
            mtlTextures[i] = (__bridge id<MTLTexture>)textures[i].GetPtr();

        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setTextures:mtlTextures
                                                        withRange:NSMakeRange(range.Location, range.Length)];
    }

    void ComputeCommandEncoder::SetSamplerState(const SamplerState& sampler, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setSamplerState:(__bridge id<MTLSamplerState>)sampler.GetPtr() atIndex:index];
    }

    void ComputeCommandEncoder::SetSamplerStates(const SamplerState* samplers, const ns::Range& range)
    {
        Validate();

        const uint32_t maxStates = 32;
        assert(range.Length <= maxStates);

        id<MTLSamplerState> mtlStates[maxStates];
        for (uint32_t i=0; i<range.Length; i++)
            mtlStates[i] = (__bridge id<MTLSamplerState>)samplers[i].GetPtr();

        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setSamplerStates:mtlStates
                                                             withRange:NSMakeRange(range.Location, range.Length)];
    }

    void ComputeCommandEncoder::SetSamplerState(const SamplerState& sampler, float lodMinClamp, float lodMaxClamp, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setSamplerState:(__bridge id<MTLSamplerState>)sampler.GetPtr()
                                                          lodMinClamp:lodMinClamp
                                                          lodMaxClamp:lodMaxClamp
                                                              atIndex:index];
    }

    void ComputeCommandEncoder::SetSamplerStates(const SamplerState* samplers, const float* lodMinClamps, const float* lodMaxClamps, const ns::Range& range)
    {
        Validate();

        const uint32_t maxStates = 32;
        assert(range.Length <= maxStates);

        id<MTLSamplerState> mtlStates[maxStates];
        for (uint32_t i=0; i<range.Length; i++)
            mtlStates[i] = (__bridge id<MTLSamplerState>)samplers[i].GetPtr();

        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setSamplerStates:mtlStates
                                                          lodMinClamps:lodMinClamps
                                                          lodMaxClamps:lodMaxClamps
                                                             withRange:NSMakeRange(range.Location, range.Length)];
    }

    void ComputeCommandEncoder::SetThreadgroupMemory(uint32_t length, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setThreadgroupMemoryLength:length atIndex:index];
    }

    void ComputeCommandEncoder::SetStageInRegion(const Region& region)
    {
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr setStageInRegion:MTLRegionMake3D(region.Origin.X, region.Origin.Y, region.Origin.Z, region.Size.Width, region.Size.Height, region.Size.Depth)];
#endif
    }

    void ComputeCommandEncoder::DispatchThreadgroups(const Size& threadgroupsPerGrid, const Size& threadsPerThreadgroup)
    {
        Validate();
        MTLSize mtlThreadgroupsPerGrid = MTLSizeMake(threadgroupsPerGrid.Width, threadgroupsPerGrid.Height, threadgroupsPerGrid.Depth);
        MTLSize mtlThreadsPerThreadgroup = MTLSizeMake(threadsPerThreadgroup.Width, threadsPerThreadgroup.Height, threadsPerThreadgroup.Depth);
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr dispatchThreadgroups:mtlThreadgroupsPerGrid threadsPerThreadgroup:mtlThreadsPerThreadgroup];
    }

    void ComputeCommandEncoder::DispatchThreadgroupsWithIndirectBuffer(const Buffer& indirectBuffer, uint32_t indirectBufferOffset, const Size& threadsPerThreadgroup)
    {
        Validate();
        MTLSize mtlThreadsPerThreadgroup = MTLSizeMake(threadsPerThreadgroup.Width, threadsPerThreadgroup.Height, threadsPerThreadgroup.Depth);
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr dispatchThreadgroupsWithIndirectBuffer:(__bridge id<MTLBuffer>)indirectBuffer.GetPtr()
                                                                        indirectBufferOffset:indirectBufferOffset
                                                                       threadsPerThreadgroup:mtlThreadsPerThreadgroup];
    }

    void ComputeCommandEncoder::UpdateFence(const Fence& fence)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr updateFence:(__bridge id<MTLFence>)fence.GetPtr()];
#endif
    }

    void ComputeCommandEncoder::WaitForFence(const Fence& fence)
    {
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        [(__bridge id<MTLComputeCommandEncoder>)m_ptr waitForFence:(__bridge id<MTLFence>)fence.GetPtr()];
#endif
    }
}
