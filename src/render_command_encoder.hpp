/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "command_encoder.hpp"
#include "command_buffer.hpp"
#include "render_pass.hpp"
#include "fence.hpp"
#include "stage_input_output_descriptor.hpp"

namespace mtlpp
{
    enum class PrimitiveType
    {
        Point         = 0,
        Line          = 1,
        LineStrip     = 2,
        Triangle      = 3,
        TriangleStrip = 4,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class VisibilityResultMode
    {
        Disabled                             = 0,
        Boolean                              = 1,
        Counting MTLPP_AVAILABLE(10_11, 9_0) = 2,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    struct ScissorRect
    {
        uint32_t X;
        uint32_t Y;
        uint32_t Width;
        uint32_t Height;
    };

    struct Viewport
    {
        double OriginX;
        double OriginY;
        double Width;
        double Height;
        double ZNear;
        double ZFar;
    };

    enum class CullMode
    {
        None  = 0,
        Front = 1,
        Back  = 2,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class Winding
    {
        Clockwise        = 0,
        CounterClockwise = 1,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class DepthClipMode
    {
        Clip  = 0,
        Clamp = 1,
    }
    MTLPP_AVAILABLE(10_11, 9_0);

    enum class TriangleFillMode
    {
        Fill  = 0,
        Lines = 1,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    struct DrawPrimitivesIndirectArguments
    {
        uint32_t VertexCount;
        uint32_t InstanceCount;
        uint32_t VertexStart;
        uint32_t BaseInstance;
    };

    struct DrawIndexedPrimitivesIndirectArguments
    {
        uint32_t IndexCount;
        uint32_t InstanceCount;
        uint32_t IndexStart;
        int32_t  BaseVertex;
        uint32_t BaseInstance;
    };

    struct DrawPatchIndirectArguments
    {
        uint32_t PatchCount;
        uint32_t InstanceCount;
        uint32_t PatchStart;
        uint32_t BaseInstance;
    };

    struct QuadTessellationFactorsHalf
    {
        uint16_t EdgeTessellationFactor[4];
        uint16_t InsideTessellationFactor[2];
    };

    struct riangleTessellationFactorsHalf
    {
        uint16_t EdgeTessellationFactor[3];
        uint16_t InsideTessellationFactor;
    };

    enum class RenderStages
    {
        Vertex   = (1 << 0),
        Fragment = (1 << 1),
    }
    MTLPP_AVAILABLE_IOS(10_0);


    class RenderCommandEncoder : public CommandEncoder
    {
    public:
        RenderCommandEncoder() { }
        RenderCommandEncoder(const ns::Handle& handle) : CommandEncoder(handle) { }

        void SetRenderPipelineState(const RenderPipelineState& pipelineState);
        void SetVertexData(const void* bytes, uint32_t length, uint32_t index) MTLPP_AVAILABLE(10_11, 8_3);
        void SetVertexBuffer(const Buffer& buffer, uint32_t offset, uint32_t index);
        void SetVertexBufferOffset(uint32_t offset, uint32_t index) MTLPP_AVAILABLE(10_11, 8_3);
        void SetVertexBuffers(const Buffer* buffers, const uint32_t* offsets, const ns::Range& range);
        void SetVertexTexture(const Texture& texture, uint32_t index);
        void SetVertexTextures(const Texture* textures, const ns::Range& range);
        void SetVertexSamplerState(const SamplerState& sampler, uint32_t index);
        void SetVertexSamplerStates(const SamplerState* samplers, const ns::Range& range);
        void SetVertexSamplerState(const SamplerState& sampler, float lodMinClamp, float lodMaxClamp, uint32_t index);
        void SetVertexSamplerStates(const SamplerState* samplers, const float* lodMinClamps, const float* lodMaxClamps, const ns::Range& range);
        void SetViewport(const Viewport& viewport);
        void SetFrontFacingWinding(Winding frontFacingWinding);
        void SetCullMode(CullMode cullMode);
        void SetDepthClipMode(DepthClipMode depthClipMode) MTLPP_AVAILABLE(10_11, NA);
        void SetDepthBias(float depthBias, float slopeScale, float clamp);
        void SetScissorRect(const ScissorRect& rect);
        void SetTriangleFillMode(TriangleFillMode fillMode);
        void SetFragmentData(const void* bytes, uint32_t length, uint32_t index);
        void SetFragmentBuffer(const Buffer& buffer, uint32_t offset, uint32_t index);
        void SetFragmentBufferOffset(uint32_t offset, uint32_t index) MTLPP_AVAILABLE(10_11, 8_3);
        void SetFragmentBuffers(const Buffer* buffers, const uint32_t* offsets, const ns::Range& range);
        void SetFragmentTexture(const Texture& texture, uint32_t index);
        void SetFragmentTextures(const Texture* textures, const ns::Range& range);
        void SetFragmentSamplerState(const SamplerState& sampler, uint32_t index);
        void SetFragmentSamplerStates(const SamplerState* samplers, const ns::Range& range);
        void SetFragmentSamplerState(const SamplerState& sampler, float lodMinClamp, float lodMaxClamp, uint32_t index);
        void SetFragmentSamplerStates(const SamplerState* samplers, const float* lodMinClamps, const float* lodMaxClamps, const ns::Range& range);
        void SetBlendColor(float red, float green, float blue, float alpha);
        void SetDepthStencilState(const DepthStencilState& depthStencilState);
        void SetStencilReferenceValue(uint32_t referenceValue);
        void SetStencilReferenceValue(uint32_t frontReferenceValue, uint32_t backReferenceValue);
        void SetVisibilityResultMode(VisibilityResultMode mode, uint32_t offset);
        void SetColorStoreAction(StoreAction storeAction, uint32_t colorAttachmentIndex) MTLPP_AVAILABLE(10_12, 10_0);
        void SetDepthStoreAction(StoreAction storeAction) MTLPP_AVAILABLE(10_12, 10_0);
        void SetStencilStoreAction(StoreAction storeAction) MTLPP_AVAILABLE(10_12, 10_0);
        void Draw(PrimitiveType primitiveType, uint32_t vertexStart, uint32_t vertexCount);
        void Draw(PrimitiveType primitiveType, uint32_t vertexStart, uint32_t vertexCount, uint32_t instanceCount) MTLPP_AVAILABLE(10_11, 9_0);
        void Draw(PrimitiveType primitiveType, uint32_t vertexStart, uint32_t vertexCount, uint32_t instanceCount, uint32_t baseInstance) MTLPP_AVAILABLE(10_11, 9_0);
        void Draw(PrimitiveType primitiveType, Buffer indirectBuffer, uint32_t indirectBufferOffset);
        void DrawIndexed(PrimitiveType primitiveType, uint32_t indexCount, IndexType indexType, const Buffer& indexBuffer, uint32_t indexBufferOffset);
        void DrawIndexed(PrimitiveType primitiveType, uint32_t indexCount, IndexType indexType, const Buffer& indexBuffer, uint32_t indexBufferOffset, uint32_t instanceCount) MTLPP_AVAILABLE(10_11, 9_0);
        void DrawIndexed(PrimitiveType primitiveType, uint32_t indexCount, IndexType indexType, const Buffer& indexBuffer, uint32_t indexBufferOffset, uint32_t instanceCount, uint32_t baseVertex, uint32_t baseInstance) MTLPP_AVAILABLE(10_11, 9_0);
        void DrawIndexed(PrimitiveType primitiveType, IndexType indexType, const Buffer& indexBuffer, uint32_t indexBufferOffset, const Buffer& indirectBuffer, uint32_t indirectBufferOffset);
        void TextureBarrier() MTLPP_AVAILABLE_MAC(10_11);
        void UpdateFence(const Fence& fence, RenderStages afterStages) MTLPP_AVAILABLE_IOS(10_0);
        void WaitForFence(const Fence& fence, RenderStages beforeStages) MTLPP_AVAILABLE_IOS(10_0);
        void SetTessellationFactorBuffer(const Buffer& buffer, uint32_t offset, uint32_t instanceStride) MTLPP_AVAILABLE(10_12, 10_0);
        void SetTessellationFactorScale(float scale) MTLPP_AVAILABLE(10_12, 10_0);
        void DrawPatches(uint32_t numberOfPatchControlPoints, uint32_t patchStart, uint32_t patchCount, const Buffer& patchIndexBuffer, uint32_t patchIndexBufferOffset, uint32_t instanceCount, uint32_t baseInstance) MTLPP_AVAILABLE(10_12, 10_0);
        void DrawPatches(uint32_t numberOfPatchControlPoints, const Buffer& patchIndexBuffer, uint32_t patchIndexBufferOffset, const Buffer& indirectBuffer, uint32_t indirectBufferOffset) MTLPP_AVAILABLE(10_12, NA);
        void DrawIndexedPatches(uint32_t numberOfPatchControlPoints, uint32_t patchStart, uint32_t patchCount, const Buffer& patchIndexBuffer, uint32_t patchIndexBufferOffset, const Buffer& controlPointIndexBuffer, uint32_t controlPointIndexBufferOffset, uint32_t instanceCount, uint32_t baseInstance) MTLPP_AVAILABLE(10_12, 10_0);
        void DrawIndexedPatches(uint32_t numberOfPatchControlPoints, const Buffer& patchIndexBuffer, uint32_t patchIndexBufferOffset, const Buffer& controlPointIndexBuffer, uint32_t controlPointIndexBufferOffset, const Buffer& indirectBuffer, uint32_t indirectBufferOffset) MTLPP_AVAILABLE(10_12, NA);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}

