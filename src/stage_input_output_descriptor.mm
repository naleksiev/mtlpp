/*
 * Copyright 2016 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "stage_input_output_descriptor.hpp"
#include <Metal/MTLStageInputOutputDescriptor.h>

namespace mtlpp
{
    BufferLayoutDescriptor::BufferLayoutDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLBufferLayoutDescriptor alloc] init] })
    {
    }

    uint32_t BufferLayoutDescriptor::GetStride() const
    {
        Validate();
        return uint32_t([(__bridge MTLBufferLayoutDescriptor*)m_ptr stride]);
    }

    StepFunction BufferLayoutDescriptor::GetStepFunction() const
    {
        Validate();
        return StepFunction([(__bridge MTLBufferLayoutDescriptor*)m_ptr stepFunction]);
    }

    uint32_t BufferLayoutDescriptor::GetStepRate() const
    {
        Validate();
        return uint32_t([(__bridge MTLBufferLayoutDescriptor*)m_ptr stepRate]);
    }

    void BufferLayoutDescriptor::SetStride(uint32_t stride)
    {
        Validate();
        [(__bridge MTLBufferLayoutDescriptor*)m_ptr setStride:stride];
    }

    void BufferLayoutDescriptor::SetStepFunction(StepFunction stepFunction)
    {
        Validate();
        [(__bridge MTLBufferLayoutDescriptor*)m_ptr setStepFunction:MTLStepFunction(stepFunction)];
    }

    void BufferLayoutDescriptor::SetStepRate(uint32_t stepRate)
    {
        Validate();
        [(__bridge MTLBufferLayoutDescriptor*)m_ptr setStepRate:stepRate];
    }

    AttributeDescriptor::AttributeDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLAttributeDescriptor alloc] init] })
    {
    }

    AttributeFormat AttributeDescriptor::GetFormat() const
    {
        Validate();
        return AttributeFormat([(__bridge MTLAttributeDescriptor*)m_ptr format]);
    }

    uint32_t AttributeDescriptor::GetOffset() const
    {
        Validate();
        return uint32_t([(__bridge MTLAttributeDescriptor*)m_ptr offset]);
    }

    uint32_t AttributeDescriptor::GetBufferIndex() const
    {
        Validate();
        return uint32_t([(__bridge MTLAttributeDescriptor*)m_ptr bufferIndex]);
    }

    void AttributeDescriptor::SetFormat(AttributeFormat format)
    {
        Validate();
        [(__bridge MTLAttributeDescriptor*)m_ptr setFormat:MTLAttributeFormat(format)];
    }

    void AttributeDescriptor::SetOffset(uint32_t offset)
    {
        Validate();
        [(__bridge MTLAttributeDescriptor*)m_ptr setOffset:offset];
    }

    void AttributeDescriptor::SetBufferIndex(uint32_t bufferIndex)
    {
        Validate();
        [(__bridge MTLAttributeDescriptor*)m_ptr setBufferIndex:bufferIndex];
    }

    StageInputOutputDescriptor::StageInputOutputDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLStageInputOutputDescriptor alloc] init] })
    {
    }

    ns::Array<BufferLayoutDescriptor> StageInputOutputDescriptor::GetLayouts() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLStageInputOutputDescriptor*)m_ptr layouts] };
    }

    ns::Array<AttributeDescriptor> StageInputOutputDescriptor::GetAttributes() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLStageInputOutputDescriptor*)m_ptr attributes] };
    }

    IndexType StageInputOutputDescriptor::GetIndexType() const
    {
        Validate();
        return IndexType([(__bridge MTLStageInputOutputDescriptor*)m_ptr indexType]);
    }

    uint32_t StageInputOutputDescriptor::GetIndexBufferIndex() const
    {
        Validate();
        return uint32_t([(__bridge MTLStageInputOutputDescriptor*)m_ptr indexBufferIndex]);
    }

    void StageInputOutputDescriptor::SetIndexType(IndexType indexType)
    {
        Validate();
        [(__bridge MTLStageInputOutputDescriptor*)m_ptr setIndexType:MTLIndexType(indexType)];
    }

    void StageInputOutputDescriptor::SetIndexBufferIndex(uint32_t indexBufferIndex)
    {
        Validate();
        [(__bridge MTLStageInputOutputDescriptor*)m_ptr setIndexBufferIndex:indexBufferIndex];
    }

    void StageInputOutputDescriptor::Reset()
    {

    }
}

