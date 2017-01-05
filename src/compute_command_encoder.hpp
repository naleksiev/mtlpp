/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"
#include "command_encoder.hpp"
#include "texture.hpp"
#include "command_buffer.hpp"
#include "fence.hpp"

namespace mtlpp
{
    class ComputeCommandEncoder : public CommandEncoder
    {
    public:
        ComputeCommandEncoder() { }
        ComputeCommandEncoder(const ns::Handle& handle) : CommandEncoder(handle) { }

        void SetComputePipelineState(const ComputePipelineState& state);
        void SetBytes(const void* data, uint32_t length, uint32_t index);
        void SetBuffer(const Buffer& buffer, uint32_t offset, uint32_t index);
        void SetBufferOffset(uint32_t offset, uint32_t index) MTLPP_AVAILABLE(10_11, 8_3);
        void SetBuffers(const Buffer* buffers, const uint32_t* offsets, const ns::Range& range);
        void SetTexture(const Texture& texture, uint32_t index);
        void SetTextures(const Texture* textures, const ns::Range& range);
        void SetSamplerState(const SamplerState& sampler, uint32_t index);
        void SetSamplerStates(const SamplerState* samplers, const ns::Range& range);
        void SetSamplerState(const SamplerState& sampler, float lodMinClamp, float lodMaxClamp, uint32_t index);
        void SetSamplerStates(const SamplerState* samplers, const float* lodMinClamps, const float* lodMaxClamps, const ns::Range& range);
        void SetThreadgroupMemory(uint32_t length, uint32_t index);
        void SetStageInRegion(const Region& region) MTLPP_AVAILABLE(10_12, 10_0);
        void DispatchThreadgroups(const Size& threadgroupsPerGrid, const Size& threadsPerThreadgroup);
        void DispatchThreadgroupsWithIndirectBuffer(const Buffer& indirectBuffer, uint32_t indirectBufferOffset, const Size& threadsPerThreadgroup);
        void UpdateFence(const Fence& fence) MTLPP_AVAILABLE_IOS(10_0);
        void WaitForFence(const Fence& fence) MTLPP_AVAILABLE_IOS(10_0);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
