/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "render_pipeline.hpp"
#include "vertex_descriptor.hpp"
#include <Metal/MTLRenderPipeline.h>

namespace mtlpp
{
    RenderPipelineColorAttachmentDescriptor::RenderPipelineColorAttachmentDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLRenderPipelineColorAttachmentDescriptor alloc] init] })
    {
    }

    PixelFormat RenderPipelineColorAttachmentDescriptor::GetPixelFormat() const
    {
        Validate();
        return PixelFormat([(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr pixelFormat]);
    }

    bool RenderPipelineColorAttachmentDescriptor::IsBlendingEnabled() const
    {
        Validate();
        return [(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr isBlendingEnabled];
    }

    BlendFactor RenderPipelineColorAttachmentDescriptor::GetSourceRgbBlendFactor() const
    {
        Validate();
        return BlendFactor([(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr sourceRGBBlendFactor]);
    }

    BlendFactor RenderPipelineColorAttachmentDescriptor::GetDestinationRgbBlendFactor() const
    {
        Validate();
        return BlendFactor([(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr destinationRGBBlendFactor]);
    }

    BlendOperation RenderPipelineColorAttachmentDescriptor::GetRgbBlendOperation() const
    {
        Validate();
        return BlendOperation([(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr rgbBlendOperation]);
    }

    BlendFactor RenderPipelineColorAttachmentDescriptor::GetSourceAlphaBlendFactor() const
    {
        Validate();
        return BlendFactor([(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr sourceAlphaBlendFactor]);
    }

    BlendFactor RenderPipelineColorAttachmentDescriptor::GetDestinationAlphaBlendFactor() const
    {
        Validate();
        return BlendFactor([(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr destinationAlphaBlendFactor]);
    }

    BlendOperation RenderPipelineColorAttachmentDescriptor::GetAlphaBlendOperation() const
    {
        Validate();
        return BlendOperation([(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr alphaBlendOperation]);
    }

    ColorWriteMask RenderPipelineColorAttachmentDescriptor::GetWriteMask() const
    {
        Validate();
        return ColorWriteMask([(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr writeMask]);
    }

    void RenderPipelineColorAttachmentDescriptor::SetPixelFormat(PixelFormat pixelFormat)
    {
        Validate();
        [(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr setPixelFormat:MTLPixelFormat(pixelFormat)];
    }

    void RenderPipelineColorAttachmentDescriptor::SetBlendingEnabled(bool blendingEnabled)
    {
        Validate();
        [(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr setBlendingEnabled:blendingEnabled];
    }

    void RenderPipelineColorAttachmentDescriptor::SetSourceRgbBlendFactor(BlendFactor sourceRgbBlendFactor)
    {
        Validate();
        [(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr setSourceRGBBlendFactor:MTLBlendFactor(sourceRgbBlendFactor)];
    }

    void RenderPipelineColorAttachmentDescriptor::SetDestinationRgbBlendFactor(BlendFactor destinationRgbBlendFactor)
    {
        Validate();
        [(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr setDestinationRGBBlendFactor:MTLBlendFactor(destinationRgbBlendFactor)];
    }

    void RenderPipelineColorAttachmentDescriptor::SetRgbBlendOperation(BlendOperation rgbBlendOperation)
    {
        Validate();
        [(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr setRgbBlendOperation:MTLBlendOperation(rgbBlendOperation)];
    }

    void RenderPipelineColorAttachmentDescriptor::SetSourceAlphaBlendFactor(BlendFactor sourceAlphaBlendFactor)
    {
        Validate();
        [(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr setSourceAlphaBlendFactor:MTLBlendFactor(sourceAlphaBlendFactor)];
    }

    void RenderPipelineColorAttachmentDescriptor::SetDestinationAlphaBlendFactor(BlendFactor destinationAlphaBlendFactor)
    {
        Validate();
        [(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr setDestinationAlphaBlendFactor:MTLBlendFactor(destinationAlphaBlendFactor)];
    }

    void RenderPipelineColorAttachmentDescriptor::SetAlphaBlendOperation(BlendOperation alphaBlendOperation)
    {
        Validate();
        [(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr setAlphaBlendOperation:MTLBlendOperation(alphaBlendOperation)];
    }

    void RenderPipelineColorAttachmentDescriptor::SetWriteMask(ColorWriteMask writeMask)
    {
        Validate();
        [(__bridge MTLRenderPipelineColorAttachmentDescriptor*)m_ptr setWriteMask:MTLColorWriteMask(writeMask)];
    }

    RenderPipelineReflection::RenderPipelineReflection() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLRenderPipelineReflection alloc] init] })
    {
    }

    const ns::Array<Argument> RenderPipelineReflection::GetVertexArguments() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPipelineReflection*)m_ptr vertexArguments] };
    }

    const ns::Array<Argument> RenderPipelineReflection::GetFragmentArguments() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPipelineReflection*)m_ptr fragmentArguments] };
    }

    RenderPipelineDescriptor::RenderPipelineDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLRenderPipelineDescriptor alloc] init] })
    {
    }

    ns::String RenderPipelineDescriptor::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPipelineDescriptor*)m_ptr label] };
    }

    Function RenderPipelineDescriptor::GetVertexFunction() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPipelineDescriptor*)m_ptr vertexFunction] };
    }

    Function RenderPipelineDescriptor::GetFragmentFunction() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPipelineDescriptor*)m_ptr fragmentFunction] };
    }

    VertexDescriptor RenderPipelineDescriptor::GetVertexDescriptor() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPipelineDescriptor*)m_ptr vertexDescriptor] };
    }

    uint32_t RenderPipelineDescriptor::GetSampleCount() const
    {
        Validate();
        return uint32_t([(__bridge MTLRenderPipelineDescriptor*)m_ptr sampleCount]);
    }

    bool RenderPipelineDescriptor::IsAlphaToCoverageEnabled() const
    {
        Validate();
        return [(__bridge MTLRenderPipelineDescriptor*)m_ptr isAlphaToCoverageEnabled];
    }

    bool RenderPipelineDescriptor::IsAlphaToOneEnabled() const
    {
        Validate();
        return [(__bridge MTLRenderPipelineDescriptor*)m_ptr isAlphaToOneEnabled];
    }

    bool RenderPipelineDescriptor::IsRasterizationEnabled() const
    {
        Validate();
        return [(__bridge MTLRenderPipelineDescriptor*)m_ptr isRasterizationEnabled];
    }

    ns::Array<RenderPipelineColorAttachmentDescriptor> RenderPipelineDescriptor::GetColorAttachments() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLRenderPipelineDescriptor*)m_ptr colorAttachments] };
    }

    PixelFormat RenderPipelineDescriptor::GetDepthAttachmentPixelFormat() const
    {
        Validate();
        return PixelFormat([(__bridge MTLRenderPipelineDescriptor*)m_ptr depthAttachmentPixelFormat]);
    }

    PixelFormat RenderPipelineDescriptor::GetStencilAttachmentPixelFormat() const
    {
        Validate();
        return PixelFormat([(__bridge MTLRenderPipelineDescriptor*)m_ptr stencilAttachmentPixelFormat]);
    }

    PrimitiveTopologyClass RenderPipelineDescriptor::GetInputPrimitiveTopology() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        return PrimitiveTopologyClass([(__bridge MTLRenderPipelineDescriptor*)m_ptr inputPrimitiveTopology]);
#else
        return PrimitiveTopologyClass(0);
#endif
    }

    TessellationPartitionMode RenderPipelineDescriptor::GetTessellationPartitionMode() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return TessellationPartitionMode([(__bridge MTLRenderPipelineDescriptor*)m_ptr tessellationPartitionMode]);
#else
        return TessellationPartitionMode(0);
#endif
    }

    uint32_t RenderPipelineDescriptor::GetMaxTessellationFactor() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return uint32_t([(__bridge MTLRenderPipelineDescriptor*)m_ptr maxTessellationFactor]);
#else
        return 0;
#endif
    }

    bool RenderPipelineDescriptor::IsTessellationFactorScaleEnabled() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return [(__bridge MTLRenderPipelineDescriptor*)m_ptr isTessellationFactorScaleEnabled];
#else
        return false;
#endif
    }

    TessellationFactorFormat RenderPipelineDescriptor::GetTessellationFactorFormat() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return TessellationFactorFormat([(__bridge MTLRenderPipelineDescriptor*)m_ptr tessellationFactorFormat]);
#else
        return TessellationFactorFormat(0);
#endif
    }

    TessellationControlPointIndexType RenderPipelineDescriptor::GetTessellationControlPointIndexType() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return TessellationControlPointIndexType([(__bridge MTLRenderPipelineDescriptor*)m_ptr tessellationControlPointIndexType]);
#else
        return TessellationControlPointIndexType(0);
#endif
    }

    TessellationFactorStepFunction RenderPipelineDescriptor::GetTessellationFactorStepFunction() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return TessellationFactorStepFunction([(__bridge MTLRenderPipelineDescriptor*)m_ptr tessellationFactorStepFunction]);
#else
        return TessellationFactorStepFunction(0);
#endif
    }

    Winding RenderPipelineDescriptor::GetTessellationOutputWindingOrder() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return Winding([(__bridge MTLRenderPipelineDescriptor*)m_ptr tessellationOutputWindingOrder]);
#else
        return Winding(0);
#endif
    }

    void RenderPipelineDescriptor::SetLabel(const ns::String& label)
    {
        Validate();
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
    }

    void RenderPipelineDescriptor::SetVertexFunction(const Function& vertexFunction)
    {
        Validate();
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setVertexFunction:(__bridge id<MTLFunction>)vertexFunction.GetPtr()];
    }

    void RenderPipelineDescriptor::SetFragmentFunction(const Function& fragmentFunction)
    {
        Validate();
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setFragmentFunction:(__bridge id<MTLFunction>)fragmentFunction.GetPtr()];
    }

    void RenderPipelineDescriptor::SetVertexDescriptor(const VertexDescriptor& vertexDescriptor)
    {
        Validate();
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setVertexDescriptor:(__bridge MTLVertexDescriptor*)vertexDescriptor.GetPtr()];
    }

    void RenderPipelineDescriptor::SetSampleCount(uint32_t sampleCount)
    {
        Validate();
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setSampleCount:sampleCount];
    }

    void RenderPipelineDescriptor::SetAlphaToCoverageEnabled(bool alphaToCoverageEnabled)
    {
        Validate();
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setAlphaToCoverageEnabled:alphaToCoverageEnabled];
    }

    void RenderPipelineDescriptor::SetAlphaToOneEnabled(bool alphaToOneEnabled)
    {
        Validate();
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setAlphaToOneEnabled:alphaToOneEnabled];
    }

    void RenderPipelineDescriptor::SetRasterizationEnabled(bool rasterizationEnabled)
    {
        Validate();
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setRasterizationEnabled:rasterizationEnabled];
    }

    void RenderPipelineDescriptor::SetDepthAttachmentPixelFormat(PixelFormat depthAttachmentPixelFormat)
    {
        Validate();
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setDepthAttachmentPixelFormat:MTLPixelFormat(depthAttachmentPixelFormat)];
    }

    void RenderPipelineDescriptor::SetStencilAttachmentPixelFormat(PixelFormat depthAttachmentPixelFormat)
    {
        Validate();
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setStencilAttachmentPixelFormat:MTLPixelFormat(depthAttachmentPixelFormat)];
    }

    void RenderPipelineDescriptor::SetInputPrimitiveTopology(PrimitiveTopologyClass inputPrimitiveTopology)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_MAC(10_11)
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setInputPrimitiveTopology:MTLPrimitiveTopologyClass(inputPrimitiveTopology)];
#endif
    }

    void RenderPipelineDescriptor::SetTessellationPartitionMode(TessellationPartitionMode tessellationPartitionMode)
    {
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setTessellationPartitionMode:MTLTessellationPartitionMode(tessellationPartitionMode)];
#endif
    }

    void RenderPipelineDescriptor::SetMaxTessellationFactor(uint32_t maxTessellationFactor)
    {
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setMaxTessellationFactor:maxTessellationFactor];
#endif
    }

    void RenderPipelineDescriptor::SetTessellationFactorScaleEnabled(bool tessellationFactorScaleEnabled)
    {
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setTessellationFactorScaleEnabled:tessellationFactorScaleEnabled];
#endif
    }

    void RenderPipelineDescriptor::SetTessellationFactorFormat(TessellationFactorFormat tessellationFactorFormat)
    {
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setTessellationFactorFormat:MTLTessellationFactorFormat(tessellationFactorFormat)];
#endif
    }

    void RenderPipelineDescriptor::SetTessellationControlPointIndexType(TessellationControlPointIndexType tessellationControlPointIndexType)
    {
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setTessellationControlPointIndexType:MTLTessellationControlPointIndexType(tessellationControlPointIndexType)];
#endif
    }

    void RenderPipelineDescriptor::SetTessellationFactorStepFunction(TessellationFactorStepFunction tessellationFactorStepFunction)
    {
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setTessellationFactorStepFunction:MTLTessellationFactorStepFunction(tessellationFactorStepFunction)];
#endif
    }

    void RenderPipelineDescriptor::SetTessellationOutputWindingOrder(Winding tessellationOutputWindingOrder)
    {
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr setTessellationOutputWindingOrder:MTLWinding(tessellationOutputWindingOrder)];
#endif
    }

    void RenderPipelineDescriptor::Reset()
    {
        [(__bridge MTLRenderPipelineDescriptor*)m_ptr reset];
    }

    ns::String RenderPipelineState::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLRenderPipelineState>)m_ptr label] };
    }

    Device RenderPipelineState::GetDevice() const
    {
        Validate();
        return ns::Handle { (__bridge void*)[(__bridge id<MTLRenderPipelineState>)m_ptr device] };
    }
}
