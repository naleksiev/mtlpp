/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "device.hpp"
#include "render_command_encoder.hpp"
#include "render_pass.hpp"
#include "pixel_format.hpp"
#include "argument.hpp"
#include "function_constant_values.hpp"

namespace mtlpp
{
    class VertexDescriptor;

    enum class BlendFactor
    {
        Zero                                                = 0,
        One                                                 = 1,
        SourceColor                                         = 2,
        OneMinusSourceColor                                 = 3,
        SourceAlpha                                         = 4,
        OneMinusSourceAlpha                                 = 5,
        DestinationColor                                    = 6,
        OneMinusDestinationColor                            = 7,
        DestinationAlpha                                    = 8,
        OneMinusDestinationAlpha                            = 9,
        SourceAlphaSaturated                                = 10,
        BlendColor                                          = 11,
        OneMinusBlendColor                                  = 12,
        BlendAlpha                                          = 13,
        OneMinusBlendAlpha                                  = 14,
        Source1Color             MTLPP_AVAILABLE_MAC(10_12) = 15,
        OneMinusSource1Color     MTLPP_AVAILABLE_MAC(10_12) = 16,
        Source1Alpha             MTLPP_AVAILABLE_MAC(10_12) = 17,
        OneMinusSource1Alpha     MTLPP_AVAILABLE_MAC(10_12) = 18,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class BlendOperation
    {
        Add             = 0,
        Subtract        = 1,
        ReverseSubtract = 2,
        Min             = 3,
        Max             = 4,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class ColorWriteMask
    {
        None  = 0,
        Red   = 0x1 << 3,
        Green = 0x1 << 2,
        Blue  = 0x1 << 1,
        Alpha = 0x1 << 0,
        All   = 0xf
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class PrimitiveTopologyClass
    {
        Unspecified = 0,
        Point       = 1,
        Line        = 2,
        Triangle    = 3,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class TessellationPartitionMode
    {
        ModePow2           = 0,
        ModeInteger        = 1,
        ModeFractionalOdd  = 2,
        ModeFractionalEven = 3,
    }
    MTLPP_AVAILABLE(10_12, 10_0);

    enum class TessellationFactorStepFunction
    {
        Constant               = 0,
        PerPatch               = 1,
        PerInstance            = 2,
        PerPatchAndPerInstance = 3,
    }
    MTLPP_AVAILABLE(10_12, 10_0);

    enum class TessellationFactorFormat
    {
        Half = 0,
    }
    MTLPP_AVAILABLE(10_12, 10_0);

    enum class TessellationControlPointIndexType
    {
        None   = 0,
        UInt16 = 1,
        UInt32 = 2,
    }
    MTLPP_AVAILABLE(10_12, 10_0);

    class RenderPipelineColorAttachmentDescriptor : public ns::Object
    {
    public:
        RenderPipelineColorAttachmentDescriptor();
        RenderPipelineColorAttachmentDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        PixelFormat     GetPixelFormat() const;
        bool            IsBlendingEnabled() const;
        BlendFactor     GetSourceRgbBlendFactor() const;
        BlendFactor     GetDestinationRgbBlendFactor() const;
        BlendOperation  GetRgbBlendOperation() const;
        BlendFactor     GetSourceAlphaBlendFactor() const;
        BlendFactor     GetDestinationAlphaBlendFactor() const;
        BlendOperation  GetAlphaBlendOperation() const;
        ColorWriteMask  GetWriteMask() const;

        void SetPixelFormat(PixelFormat pixelFormat);
        void SetBlendingEnabled(bool blendingEnabled);
        void SetSourceRgbBlendFactor(BlendFactor sourceRgbBlendFactor);
        void SetDestinationRgbBlendFactor(BlendFactor destinationRgbBlendFactor);
        void SetRgbBlendOperation(BlendOperation rgbBlendOperation);
        void SetSourceAlphaBlendFactor(BlendFactor sourceAlphaBlendFactor);
        void SetDestinationAlphaBlendFactor(BlendFactor destinationAlphaBlendFactor);
        void SetAlphaBlendOperation(BlendOperation alphaBlendOperation);
        void SetWriteMask(ColorWriteMask writeMask);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class RenderPipelineReflection : public ns::Object
    {
    public:
        RenderPipelineReflection();
        RenderPipelineReflection(const ns::Handle& handle) : ns::Object(handle) { }

        const ns::Array<Argument> GetVertexArguments() const;
        const ns::Array<Argument> GetFragmentArguments() const;
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class RenderPipelineDescriptor : public ns::Object
    {
    public:
        RenderPipelineDescriptor();
        RenderPipelineDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String                                         GetLabel() const;
        Function                                           GetVertexFunction() const;
        Function                                           GetFragmentFunction() const;
        VertexDescriptor                                   GetVertexDescriptor() const;
        uint32_t                                           GetSampleCount() const;
        bool                                               IsAlphaToCoverageEnabled() const;
        bool                                               IsAlphaToOneEnabled() const;
        bool                                               IsRasterizationEnabled() const;
        ns::Array<RenderPipelineColorAttachmentDescriptor> GetColorAttachments() const;
        PixelFormat                                        GetDepthAttachmentPixelFormat() const;
        PixelFormat                                        GetStencilAttachmentPixelFormat() const;
        PrimitiveTopologyClass                             GetInputPrimitiveTopology() const MTLPP_AVAILABLE_MAC(10_11);
        TessellationPartitionMode                          GetTessellationPartitionMode() const MTLPP_AVAILABLE(10_12, 10_0);
        uint32_t                                           GetMaxTessellationFactor() const MTLPP_AVAILABLE(10_12, 10_0);
        bool                                               IsTessellationFactorScaleEnabled() const MTLPP_AVAILABLE(10_12, 10_0);
        TessellationFactorFormat                           GetTessellationFactorFormat() const MTLPP_AVAILABLE(10_12, 10_0);
        TessellationControlPointIndexType                  GetTessellationControlPointIndexType() const MTLPP_AVAILABLE(10_12, 10_0);
        TessellationFactorStepFunction                     GetTessellationFactorStepFunction() const MTLPP_AVAILABLE(10_12, 10_0);
        Winding                                            GetTessellationOutputWindingOrder() const MTLPP_AVAILABLE(10_12, 10_0);


        void SetLabel(const ns::String& label);
        void SetVertexFunction(const Function& vertexFunction);
        void SetFragmentFunction(const Function& fragmentFunction);
        void SetVertexDescriptor(const VertexDescriptor& vertexDescriptor);
        void SetSampleCount(uint32_t sampleCount);
        void SetAlphaToCoverageEnabled(bool alphaToCoverageEnabled);
        void SetAlphaToOneEnabled(bool alphaToOneEnabled);
        void SetRasterizationEnabled(bool rasterizationEnabled);
        void SetDepthAttachmentPixelFormat(PixelFormat depthAttachmentPixelFormat);
        void SetStencilAttachmentPixelFormat(PixelFormat stencilAttachmentPixelFormat);
        void SetInputPrimitiveTopology(PrimitiveTopologyClass inputPrimitiveTopology) MTLPP_AVAILABLE_MAC(10_11);
        void SetTessellationPartitionMode(TessellationPartitionMode tessellationPartitionMode) MTLPP_AVAILABLE(10_12, 10_0);
        void SetMaxTessellationFactor(uint32_t maxTessellationFactor) MTLPP_AVAILABLE(10_12, 10_0);
        void SetTessellationFactorScaleEnabled(bool tessellationFactorScaleEnabled) MTLPP_AVAILABLE(10_12, 10_0);
        void SetTessellationFactorFormat(TessellationFactorFormat tessellationFactorFormat) MTLPP_AVAILABLE(10_12, 10_0);
        void SetTessellationControlPointIndexType(TessellationControlPointIndexType tessellationControlPointIndexType) MTLPP_AVAILABLE(10_12, 10_0);
        void SetTessellationFactorStepFunction(TessellationFactorStepFunction tessellationFactorStepFunction) MTLPP_AVAILABLE(10_12, 10_0);
        void SetTessellationOutputWindingOrder(Winding tessellationOutputWindingOrder) MTLPP_AVAILABLE(10_12, 10_0);

        void Reset();
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class RenderPipelineState : public ns::Object
    {
    public:
        RenderPipelineState() { }
        RenderPipelineState(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String GetLabel() const;
        Device     GetDevice() const;
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
