/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"

namespace mtlpp
{
    enum class VertexFormat
    {
        Invalid               = 0,

        UChar2                = 1,
        UChar3                = 2,
        UChar4                = 3,

        Char2                 = 4,
        Char3                 = 5,
        Char4                 = 6,

        UChar2Normalized      = 7,
        UChar3Normalized      = 8,
        UChar4Normalized      = 9,

        Char2Normalized       = 10,
        Char3Normalized       = 11,
        Char4Normalized       = 12,

        UShort2               = 13,
        UShort3               = 14,
        UShort4               = 15,

        Short2                = 16,
        Short3                = 17,
        Short4                = 18,

        UShort2Normalized     = 19,
        UShort3Normalized     = 20,
        UShort4Normalized     = 21,

        Short2Normalized      = 22,
        Short3Normalized      = 23,
        Short4Normalized      = 24,

        Half2                 = 25,
        Half3                 = 26,
        Half4                 = 27,

        Float                 = 28,
        Float2                = 29,
        Float3                = 30,
        Float4                = 31,

        Int                   = 32,
        Int2                  = 33,
        Int3                  = 34,
        Int4                  = 35,

        UInt                  = 36,
        UInt2                 = 37,
        UInt3                 = 38,
        UInt4                 = 39,

        Int1010102Normalized  = 40,
        UInt1010102Normalized = 41,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class VertexStepFunction
    {
        Constant                                          = 0,
        PerVertex                                         = 1,
        PerInstance                                       = 2,
        PerPatch             MTLPP_AVAILABLE(10_12, 10_0) = 3,
        PerPatchControlPoint MTLPP_AVAILABLE(10_12, 10_0) = 4,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class VertexBufferLayoutDescriptor : public ns::Object
    {
    public:
        VertexBufferLayoutDescriptor();
        VertexBufferLayoutDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        uint32_t           GetStride() const;
        VertexStepFunction GetStepFunction() const;
        uint32_t           GetStepRate() const;

        void SetStride(uint32_t stride);
        void SetStepFunction(VertexStepFunction stepFunction);
        void SetStepRate(uint32_t stepRate);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class VertexAttributeDescriptor : public ns::Object
    {
    public:
        VertexAttributeDescriptor();
        VertexAttributeDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        VertexFormat GetFormat() const;
        uint32_t     GetOffset() const;
        uint32_t     GetBufferIndex() const;

        void SetFormat(VertexFormat format);
        void SetOffset(uint32_t offset);
        void SetBufferIndex(uint32_t bufferIndex);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class VertexDescriptor : public ns::Object
    {
    public:
        VertexDescriptor();
        VertexDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        ns::Array<VertexBufferLayoutDescriptor> GetLayouts() const;
        ns::Array<VertexAttributeDescriptor>    GetAttributes() const;

        void Reset();
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
