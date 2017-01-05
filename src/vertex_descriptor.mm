/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "vertex_descriptor.hpp"
#include <Metal/MTLVertexDescriptor.h>

namespace mtlpp
{
    VertexBufferLayoutDescriptor::VertexBufferLayoutDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLVertexBufferLayoutDescriptor alloc] init] })
    {
    }

    uint32_t VertexBufferLayoutDescriptor::GetStride() const
    {
        Validate();
        return uint32_t([(__bridge MTLVertexBufferLayoutDescriptor*)m_ptr stride]);
    }

    uint32_t VertexBufferLayoutDescriptor::GetStepRate() const
    {
        Validate();
        return uint32_t([(__bridge MTLVertexBufferLayoutDescriptor*)m_ptr stepRate]);
    }

    VertexStepFunction VertexBufferLayoutDescriptor::GetStepFunction() const
    {
        Validate();
        return VertexStepFunction([(__bridge MTLVertexBufferLayoutDescriptor*)m_ptr stepFunction]);
    }

    void VertexBufferLayoutDescriptor::SetStride(uint32_t stride)
    {
        Validate();
        [(__bridge MTLVertexBufferLayoutDescriptor*)m_ptr setStride:stride];
    }

    void VertexBufferLayoutDescriptor::SetStepRate(uint32_t stepRate)
    {
        Validate();
        [(__bridge MTLVertexBufferLayoutDescriptor*)m_ptr setStepRate:stepRate];
    }

    void VertexBufferLayoutDescriptor::SetStepFunction(VertexStepFunction stepFunction)
    {
        Validate();
        [(__bridge MTLVertexBufferLayoutDescriptor*)m_ptr setStepFunction:MTLVertexStepFunction(stepFunction)];
    }

    VertexAttributeDescriptor::VertexAttributeDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLVertexAttributeDescriptor alloc] init] })
    {
    }

    VertexFormat VertexAttributeDescriptor::GetFormat() const
    {
        Validate();
        return VertexFormat([(__bridge MTLVertexAttributeDescriptor*)m_ptr format]);
    }

    uint32_t VertexAttributeDescriptor::GetOffset() const
    {
        Validate();
        return uint32_t([(__bridge MTLVertexAttributeDescriptor*)m_ptr offset]);
    }

    uint32_t VertexAttributeDescriptor::GetBufferIndex() const
    {
        Validate();
        return uint32_t([(__bridge MTLVertexAttributeDescriptor*)m_ptr bufferIndex]);
    }

    void VertexAttributeDescriptor::SetFormat(VertexFormat format)
    {
        Validate();
        [(__bridge MTLVertexAttributeDescriptor*)m_ptr setFormat:MTLVertexFormat(format)];
    }

    void VertexAttributeDescriptor::SetOffset(uint32_t offset)
    {
        Validate();
        [(__bridge MTLVertexAttributeDescriptor*)m_ptr setOffset:offset];
    }

    void VertexAttributeDescriptor::SetBufferIndex(uint32_t bufferIndex)
    {
        Validate();
        [(__bridge MTLVertexAttributeDescriptor*)m_ptr setBufferIndex:bufferIndex];
    }

    VertexDescriptor::VertexDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLVertexDescriptor alloc] init] })
    {
    }

    ns::Array<VertexBufferLayoutDescriptor> VertexDescriptor::GetLayouts() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLVertexDescriptor*)m_ptr layouts] };
    }

    ns::Array<VertexAttributeDescriptor> VertexDescriptor::GetAttributes() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLVertexDescriptor*)m_ptr attributes] };
    }

    void VertexDescriptor::Reset()
    {
        Validate();
        [(__bridge MTLVertexDescriptor*)m_ptr reset];
    }
}
