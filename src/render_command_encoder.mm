/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "render_command_encoder.hpp"
#include "buffer.hpp"
#include "depth_stencil.hpp"
#include "render_pipeline.hpp"
#include "sampler.hpp"
#include "texture.hpp"
#include <Metal/MTLRenderCommandEncoder.h>
#include <Metal/MTLBuffer.h>

namespace mtlpp
{
    void RenderCommandEncoder::SetRenderPipelineState(const RenderPipelineState& pipelineState)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setRenderPipelineState:(__bridge id<MTLRenderPipelineState>)pipelineState.GetPtr()];
    }

    void RenderCommandEncoder::SetVertexData(const void* bytes, uint32_t length, uint32_t index)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 8_3)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVertexBytes:bytes length:length atIndex:index];
#endif
    }

    void RenderCommandEncoder::SetVertexBuffer(const Buffer& buffer, uint32_t offset, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVertexBuffer:(__bridge id<MTLBuffer>)buffer.GetPtr()
                                                              offset:offset
                                                             atIndex:index];
    }
    void RenderCommandEncoder::SetVertexBufferOffset(uint32_t offset, uint32_t index)
    {
#if MTLPP_IS_AVAILABLE(10_11, 8_3)
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVertexBufferOffset:offset atIndex:index];
#endif
    }

    void RenderCommandEncoder::SetVertexBuffers(const Buffer* buffers, const uint32_t* offsets, const ns::Range& range)
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

        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVertexBuffers:mtlBuffers offsets:nsOffsets withRange:NSMakeRange(range.Location, range.Length)];
    }

    void RenderCommandEncoder::SetVertexTexture(const Texture& texture, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVertexTexture:(__bridge id<MTLTexture>)texture.GetPtr()
                                                              atIndex:index];
    }


    void RenderCommandEncoder::SetVertexTextures(const Texture* textures, const ns::Range& range)
    {
        Validate();

        const uint32_t maxTextures = 32;
        assert(range.Length <= maxTextures);

        id<MTLTexture> mtlTextures[maxTextures];
        for (uint32_t i=0; i<range.Length; i++)
            mtlTextures[i] = (__bridge id<MTLTexture>)textures[i].GetPtr();

        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVertexTextures:mtlTextures withRange:NSMakeRange(range.Location, range.Length)];
    }

    void RenderCommandEncoder::SetVertexSamplerState(const SamplerState& sampler, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVertexSamplerState:(__bridge id<MTLSamplerState>)sampler.GetPtr()
                                                                   atIndex:index];

    }

    void RenderCommandEncoder::SetVertexSamplerStates(const SamplerState* samplers, const ns::Range& range)
    {
        Validate();

        const uint32_t maxStates = 32;
        assert(range.Length <= maxStates);

        id<MTLSamplerState> mtlStates[maxStates];
        for (uint32_t i=0; i<range.Length; i++)
            mtlStates[i] = (__bridge id<MTLSamplerState>)samplers[i].GetPtr();

        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVertexSamplerStates:mtlStates withRange:NSMakeRange(range.Location, range.Length)];
    }

    void RenderCommandEncoder::SetVertexSamplerState(const SamplerState& sampler, float lodMinClamp, float lodMaxClamp, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVertexSamplerState:(__bridge id<MTLSamplerState>)sampler.GetPtr()
                                                               lodMinClamp:lodMinClamp
                                                               lodMaxClamp:lodMaxClamp
                                                                   atIndex:index];
    }

    void RenderCommandEncoder::SetVertexSamplerStates(const SamplerState* samplers, const float* lodMinClamps, const float* lodMaxClamps, const ns::Range& range)
    {
        Validate();

        const uint32_t maxStates = 32;
        assert(range.Length <= maxStates);

        id<MTLSamplerState> mtlStates[maxStates];
        for (uint32_t i=0; i<range.Length; i++)
            mtlStates[i] = (__bridge id<MTLSamplerState>)samplers[i].GetPtr();

        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVertexSamplerStates:mtlStates
                                                               lodMinClamps:lodMinClamps
                                                               lodMaxClamps:lodMaxClamps
                                                                  withRange:NSMakeRange(range.Location, range.Length)];
    }

    void RenderCommandEncoder::SetViewport(const Viewport& viewport)
    {
        Validate();
        MTLViewport mtlViewport = { viewport.OriginX, viewport.OriginY, viewport.Width, viewport.Height, viewport.ZNear, viewport.ZFar };
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setViewport:mtlViewport];
    }

    void RenderCommandEncoder::SetFrontFacingWinding(Winding frontFacingWinding)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFrontFacingWinding:MTLWinding(frontFacingWinding)];
    }

    void RenderCommandEncoder::SetCullMode(CullMode cullMode)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setCullMode:MTLCullMode(cullMode)];
    }

    void RenderCommandEncoder::SetDepthClipMode(DepthClipMode depthClipMode)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setDepthClipMode:MTLDepthClipMode(depthClipMode)];
#endif
    }

    void RenderCommandEncoder::SetDepthBias(float depthBias, float slopeScale, float clamp)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setDepthBias:depthBias slopeScale:slopeScale clamp:clamp];
    }

    void RenderCommandEncoder::SetScissorRect(const ScissorRect& rect)
    {
        Validate();
        MTLScissorRect mtlRect { rect.X, rect.Y, rect.Width, rect.Height };
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setScissorRect:mtlRect];
    }

    void RenderCommandEncoder::SetTriangleFillMode(TriangleFillMode fillMode)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setTriangleFillMode:MTLTriangleFillMode(fillMode)];
    }

    void RenderCommandEncoder::SetFragmentData(const void* bytes, uint32_t length, uint32_t index)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 8_3)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFragmentBytes:bytes
                                                               length:length
                                                              atIndex:index];
#endif
    }

    void RenderCommandEncoder::SetFragmentBuffer(const Buffer& buffer, uint32_t offset, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFragmentBuffer:(__bridge id<MTLBuffer>)buffer.GetPtr()
                                                                offset:offset
                                                               atIndex:index];
    }

    void RenderCommandEncoder::SetFragmentBufferOffset(uint32_t offset, uint32_t index)
    {
#if MTLPP_IS_AVAILABLE(10_11, 8_3)
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFragmentBufferOffset:offset atIndex:index];
#endif
    }

    void RenderCommandEncoder::SetFragmentBuffers(const Buffer* buffers, const uint32_t* offsets, const ns::Range& range)
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

        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFragmentBuffers:mtlBuffers offsets:nsOffsets withRange:NSMakeRange(range.Location, range.Length)];
    }

    void RenderCommandEncoder::SetFragmentTexture(const Texture& texture, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFragmentTexture:(__bridge id<MTLTexture>)texture.GetPtr()
                                                                atIndex:index];
    }

    void RenderCommandEncoder::SetFragmentTextures(const Texture* textures, const ns::Range& range)
    {
        Validate();

        const uint32_t maxTextures = 32;
        assert(range.Length <= maxTextures);

        id<MTLTexture> mtlTextures[maxTextures];
        for (uint32_t i=0; i<range.Length; i++)
            mtlTextures[i] = (__bridge id<MTLTexture>)textures[i].GetPtr();

        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFragmentTextures:mtlTextures withRange:NSMakeRange(range.Location, range.Length)];
    }

    void RenderCommandEncoder::SetFragmentSamplerState(const SamplerState& sampler, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFragmentSamplerState:(__bridge id<MTLSamplerState>)sampler.GetPtr()
                                                                     atIndex:index];
    }

    void RenderCommandEncoder::SetFragmentSamplerStates(const SamplerState* samplers, const ns::Range& range)
    {
        Validate();

        const uint32_t maxStates = 32;
        assert(range.Length <= maxStates);

        id<MTLSamplerState> mtlStates[maxStates];
        for (uint32_t i=0; i<range.Length; i++)
            mtlStates[i] = (__bridge id<MTLSamplerState>)samplers[i].GetPtr();

        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFragmentSamplerStates:mtlStates withRange:NSMakeRange(range.Location, range.Length)];
    }

    void RenderCommandEncoder::SetFragmentSamplerState(const SamplerState& sampler, float lodMinClamp, float lodMaxClamp, uint32_t index)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFragmentSamplerState:(__bridge id<MTLSamplerState>)sampler.GetPtr()
                                                                 lodMinClamp:lodMinClamp
                                                                 lodMaxClamp:lodMaxClamp
                                                                     atIndex:index];
    }

    void RenderCommandEncoder::SetFragmentSamplerStates(const SamplerState* samplers, const float* lodMinClamps, const float* lodMaxClamps, const ns::Range& range)
    {
        Validate();

        const uint32_t maxStates = 32;
        assert(range.Length <= maxStates);

        id<MTLSamplerState> mtlStates[maxStates];
        for (uint32_t i=0; i<range.Length; i++)
            mtlStates[i] = (__bridge id<MTLSamplerState>)samplers[i].GetPtr();

        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setFragmentSamplerStates:mtlStates
                                                                 lodMinClamps:lodMinClamps
                                                                 lodMaxClamps:lodMaxClamps
                                                                    withRange:NSMakeRange(range.Location, range.Length)];
    }

    void RenderCommandEncoder::SetBlendColor(float red, float green, float blue, float alpha)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setBlendColorRed:red green:green blue:blue alpha:alpha];
    }

    void RenderCommandEncoder::SetDepthStencilState(const DepthStencilState& depthStencilState)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setDepthStencilState:(__bridge id<MTLDepthStencilState>)depthStencilState.GetPtr()];
    }

    void RenderCommandEncoder::SetStencilReferenceValue(uint32_t referenceValue)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setStencilReferenceValue:referenceValue];
    }

    void RenderCommandEncoder::SetStencilReferenceValue(uint32_t frontReferenceValue, uint32_t backReferenceValue)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setStencilFrontReferenceValue:frontReferenceValue backReferenceValue:backReferenceValue];
    }

    void RenderCommandEncoder::SetVisibilityResultMode(VisibilityResultMode mode, uint32_t offset)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setVisibilityResultMode:MTLVisibilityResultMode(mode) offset:offset];
    }

    void RenderCommandEncoder::SetColorStoreAction(StoreAction storeAction, uint32_t colorAttachmentIndex)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setColorStoreAction:MTLStoreAction(storeAction) atIndex:colorAttachmentIndex];
#endif
    }

    void RenderCommandEncoder::SetDepthStoreAction(StoreAction storeAction)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setDepthStoreAction:MTLStoreAction(storeAction)];
#endif
    }

    void RenderCommandEncoder::SetStencilStoreAction(StoreAction storeAction)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setStencilStoreAction:MTLStoreAction(storeAction)];
#endif
    }

    void RenderCommandEncoder::Draw(PrimitiveType primitiveType, uint32_t vertexStart, uint32_t vertexCount)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawPrimitives:MTLPrimitiveType(primitiveType)
                                                        vertexStart:vertexStart
                                                        vertexCount:vertexCount];
    }

    void RenderCommandEncoder::Draw(PrimitiveType primitiveType, uint32_t vertexStart, uint32_t vertexCount, uint32_t instanceCount)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawPrimitives:MTLPrimitiveType(primitiveType)
                                                        vertexStart:vertexStart
                                                        vertexCount:vertexCount
                                                      instanceCount:instanceCount];
#endif
    }

    void RenderCommandEncoder::Draw(PrimitiveType primitiveType, uint32_t vertexStart, uint32_t vertexCount, uint32_t instanceCount, uint32_t baseInstance)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawPrimitives:MTLPrimitiveType(primitiveType)
                                                        vertexStart:vertexStart
                                                        vertexCount:vertexCount
                                                      instanceCount:instanceCount
                                                       baseInstance:baseInstance];
#endif
    }

    void RenderCommandEncoder::Draw(PrimitiveType primitiveType, Buffer indirectBuffer, uint32_t indirectBufferOffset)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawPrimitives:MTLPrimitiveType(primitiveType)
                                                     indirectBuffer:(__bridge id<MTLBuffer>)indirectBuffer.GetPtr()
                                               indirectBufferOffset:indirectBufferOffset];
    }

    void RenderCommandEncoder::DrawIndexed(PrimitiveType primitiveType, uint32_t indexCount, IndexType indexType, const Buffer& indexBuffer, uint32_t indexBufferOffset)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawIndexedPrimitives:MTLPrimitiveType(primitiveType)
                                                                indexCount:indexCount
                                                                 indexType:MTLIndexType(indexType)
                                                               indexBuffer:(__bridge id<MTLBuffer>)indexBuffer.GetPtr()
                                                         indexBufferOffset:indexBufferOffset];
    }

    void RenderCommandEncoder::DrawIndexed(PrimitiveType primitiveType, uint32_t indexCount, IndexType indexType, const Buffer& indexBuffer, uint32_t indexBufferOffset, uint32_t instanceCount)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawIndexedPrimitives:MTLPrimitiveType(primitiveType)
                                                                indexCount:indexCount indexType:MTLIndexType(indexType)
                                                               indexBuffer:(__bridge id<MTLBuffer>)indexBuffer.GetPtr()
                                                         indexBufferOffset:indexBufferOffset instanceCount:instanceCount];
#endif
    }

    void RenderCommandEncoder::DrawIndexed(PrimitiveType primitiveType, uint32_t indexCount, IndexType indexType, const Buffer& indexBuffer, uint32_t indexBufferOffset, uint32_t instanceCount, uint32_t baseVertex, uint32_t baseInstance)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawIndexedPrimitives:MTLPrimitiveType(primitiveType)
                                                                indexCount:indexCount
                                                                 indexType:MTLIndexType(indexType)
                                                               indexBuffer:(__bridge id<MTLBuffer>)indexBuffer.GetPtr()
                                                         indexBufferOffset:indexBufferOffset
                                                             instanceCount:instanceCount
                                                                baseVertex:baseVertex
                                                              baseInstance:baseInstance];
#endif
    }

    void RenderCommandEncoder::DrawIndexed(PrimitiveType primitiveType, IndexType indexType, const Buffer& indexBuffer, uint32_t indexBufferOffset, const Buffer& indirectBuffer, uint32_t indirectBufferOffset)
    {
        Validate();
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawIndexedPrimitives:MTLPrimitiveType(primitiveType)
                                                                 indexType:MTLIndexType(indexType)
                                                               indexBuffer:(__bridge id<MTLBuffer>)indexBuffer.GetPtr()
                                                         indexBufferOffset:indexBufferOffset
                                                            indirectBuffer:(__bridge id<MTLBuffer>)indirectBuffer.GetPtr()
                                                      indirectBufferOffset:indirectBufferOffset];
    }

    void RenderCommandEncoder::TextureBarrier()
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr textureBarrier];
#endif
    }

    void RenderCommandEncoder::UpdateFence(const Fence& fence, RenderStages afterStages)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr updateFence:(__bridge id<MTLFence>)fence.GetPtr() afterStages:MTLRenderStages(afterStages)];
#endif
    }

    void RenderCommandEncoder::WaitForFence(const Fence& fence, RenderStages beforeStages)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr waitForFence:(__bridge id<MTLFence>)fence.GetPtr() beforeStages:MTLRenderStages(beforeStages)];
#endif
    }

    void RenderCommandEncoder::SetTessellationFactorBuffer(const Buffer& buffer, uint32_t offset, uint32_t instanceStride)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setTessellationFactorBuffer:(__bridge id<MTLBuffer>)buffer.GetPtr() offset:offset instanceStride:instanceStride];
#endif
    }

    void RenderCommandEncoder::SetTessellationFactorScale(float scale)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr setTessellationFactorScale:scale];
#endif
    }

    void RenderCommandEncoder::DrawPatches(uint32_t numberOfPatchControlPoints, uint32_t patchStart, uint32_t patchCount, const Buffer& patchIndexBuffer, uint32_t patchIndexBufferOffset, uint32_t instanceCount, uint32_t baseInstance)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawPatches:numberOfPatchControlPoints
                                                      patchStart:patchStart
                                                      patchCount:patchCount
                                                patchIndexBuffer:(__bridge id<MTLBuffer>)patchIndexBuffer.GetPtr()
                                          patchIndexBufferOffset:patchIndexBufferOffset
                                                   instanceCount:instanceCount
                                                    baseInstance:baseInstance];
#endif
    }

    void RenderCommandEncoder::DrawPatches(uint32_t numberOfPatchControlPoints, const Buffer& patchIndexBuffer, uint32_t patchIndexBufferOffset, const Buffer& indirectBuffer, uint32_t indirectBufferOffset)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_12)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawPatches:numberOfPatchControlPoints
                                                patchIndexBuffer:(__bridge id<MTLBuffer>)patchIndexBuffer.GetPtr()
                                          patchIndexBufferOffset:patchIndexBufferOffset
                                                  indirectBuffer:(__bridge id<MTLBuffer>)indirectBuffer.GetPtr()
                                            indirectBufferOffset:indirectBufferOffset];
#endif
    }

    void RenderCommandEncoder::DrawIndexedPatches(uint32_t numberOfPatchControlPoints, uint32_t patchStart, uint32_t patchCount, const Buffer& patchIndexBuffer, uint32_t patchIndexBufferOffset, const Buffer& controlPointIndexBuffer, uint32_t controlPointIndexBufferOffset, uint32_t instanceCount, uint32_t baseInstance)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawIndexedPatches:numberOfPatchControlPoints
                                                             patchStart:patchStart
                                                             patchCount:patchCount
                                                       patchIndexBuffer:(__bridge id<MTLBuffer>)patchIndexBuffer.GetPtr()
                                                 patchIndexBufferOffset:patchIndexBufferOffset
                                                controlPointIndexBuffer:(__bridge id<MTLBuffer>)controlPointIndexBuffer.GetPtr()
                                          controlPointIndexBufferOffset:controlPointIndexBufferOffset
                                                          instanceCount:instanceCount
                                                           baseInstance:baseInstance];
#endif
    }

    void RenderCommandEncoder::DrawIndexedPatches(uint32_t numberOfPatchControlPoints, const Buffer& patchIndexBuffer, uint32_t patchIndexBufferOffset, const Buffer& controlPointIndexBuffer, uint32_t controlPointIndexBufferOffset, const Buffer& indirectBuffer, uint32_t indirectBufferOffset)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_12)
        [(__bridge id<MTLRenderCommandEncoder>)m_ptr drawIndexedPatches:numberOfPatchControlPoints
                                                       patchIndexBuffer:(__bridge id<MTLBuffer>)patchIndexBuffer.GetPtr()
                                                 patchIndexBufferOffset:patchIndexBufferOffset
                                                controlPointIndexBuffer:(__bridge id<MTLBuffer>)controlPointIndexBuffer.GetPtr()
                                          controlPointIndexBufferOffset:controlPointIndexBufferOffset
                                                         indirectBuffer:(__bridge id<MTLBuffer>)indirectBuffer.GetPtr()
                                                   indirectBufferOffset:indirectBufferOffset];
#endif
    }
}

