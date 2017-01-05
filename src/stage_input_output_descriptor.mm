/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "stage_input_output_descriptor.hpp"
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
#   include <Metal/MTLStageInputOutputDescriptor.h>
#endif

namespace mtlpp
{
    BufferLayoutDescriptor::BufferLayoutDescriptor() :
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        ns::Object(ns::Handle{ (__bridge void*)[[MTLBufferLayoutDescriptor alloc] init] })
#else
        ns::Object(ns::Handle{ nullptr })
#endif
    {
    }

    uint32_t BufferLayoutDescriptor::GetStride() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return uint32_t([(__bridge MTLBufferLayoutDescriptor*)m_ptr stride]);
#else
        return 0;
#endif
    }

    StepFunction BufferLayoutDescriptor::GetStepFunction() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return StepFunction([(__bridge MTLBufferLayoutDescriptor*)m_ptr stepFunction]);
#else
        return StepFunction(0);
#endif
    }

    uint32_t BufferLayoutDescriptor::GetStepRate() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return uint32_t([(__bridge MTLBufferLayoutDescriptor*)m_ptr stepRate]);
#else
        return 0;
#endif
    }

    void BufferLayoutDescriptor::SetStride(uint32_t stride)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLBufferLayoutDescriptor*)m_ptr setStride:stride];
#endif
    }

    void BufferLayoutDescriptor::SetStepFunction(StepFunction stepFunction)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLBufferLayoutDescriptor*)m_ptr setStepFunction:MTLStepFunction(stepFunction)];
#endif
    }

    void BufferLayoutDescriptor::SetStepRate(uint32_t stepRate)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLBufferLayoutDescriptor*)m_ptr setStepRate:stepRate];
#endif
    }

    AttributeDescriptor::AttributeDescriptor() :
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        ns::Object(ns::Handle{ (__bridge void*)[[MTLAttributeDescriptor alloc] init] })
#else
        ns::Object(ns::Handle{ nullptr })
#endif
    {
    }

    AttributeFormat AttributeDescriptor::GetFormat() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return AttributeFormat([(__bridge MTLAttributeDescriptor*)m_ptr format]);
#else
        return AttributeFormat(0);
#endif
    }

    uint32_t AttributeDescriptor::GetOffset() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return uint32_t([(__bridge MTLAttributeDescriptor*)m_ptr offset]);
#else
        return 0;
#endif
    }

    uint32_t AttributeDescriptor::GetBufferIndex() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return uint32_t([(__bridge MTLAttributeDescriptor*)m_ptr bufferIndex]);
#else
        return 0;
#endif
    }

    void AttributeDescriptor::SetFormat(AttributeFormat format)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLAttributeDescriptor*)m_ptr setFormat:MTLAttributeFormat(format)];
#endif
    }

    void AttributeDescriptor::SetOffset(uint32_t offset)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLAttributeDescriptor*)m_ptr setOffset:offset];
#endif
    }

    void AttributeDescriptor::SetBufferIndex(uint32_t bufferIndex)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLAttributeDescriptor*)m_ptr setBufferIndex:bufferIndex];
#endif
    }

    StageInputOutputDescriptor::StageInputOutputDescriptor() :
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        ns::Object(ns::Handle{ (__bridge void*)[[MTLStageInputOutputDescriptor alloc] init] })
#else
        ns::Object(ns::Handle{ nullptr })
#endif
    {
    }

    ns::Array<BufferLayoutDescriptor> StageInputOutputDescriptor::GetLayouts() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return ns::Handle{ (__bridge void*)[(__bridge MTLStageInputOutputDescriptor*)m_ptr layouts] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    ns::Array<AttributeDescriptor> StageInputOutputDescriptor::GetAttributes() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return ns::Handle{ (__bridge void*)[(__bridge MTLStageInputOutputDescriptor*)m_ptr attributes] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    IndexType StageInputOutputDescriptor::GetIndexType() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return IndexType([(__bridge MTLStageInputOutputDescriptor*)m_ptr indexType]);
#else
        return IndexType(0);
#endif
    }

    uint32_t StageInputOutputDescriptor::GetIndexBufferIndex() const
   {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return uint32_t([(__bridge MTLStageInputOutputDescriptor*)m_ptr indexBufferIndex]);
#else
        return 0;
#endif
    }

   void StageInputOutputDescriptor::SetIndexType(IndexType indexType)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLStageInputOutputDescriptor*)m_ptr setIndexType:MTLIndexType(indexType)];
#endif
    }

    void StageInputOutputDescriptor::SetIndexBufferIndex(uint32_t indexBufferIndex)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLStageInputOutputDescriptor*)m_ptr setIndexBufferIndex:indexBufferIndex];
#endif
    }

    void StageInputOutputDescriptor::Reset()
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLStageInputOutputDescriptor*)m_ptr reset];
#endif
    }
}

