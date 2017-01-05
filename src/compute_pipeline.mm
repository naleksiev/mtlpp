/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "compute_pipeline.hpp"
#include <Metal/MTLComputePipeline.h>

namespace mtlpp
{
    ComputePipelineReflection::ComputePipelineReflection() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLComputePipelineReflection alloc] init] })
    {
    }

    ComputePipelineDescriptor::ComputePipelineDescriptor() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLComputePipelineDescriptor alloc] init] })
    {
    }

    ns::String ComputePipelineDescriptor::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLComputePipelineDescriptor*)m_ptr label] };
    }

    Function ComputePipelineDescriptor::GetComputeFunction() const
    {
        Validate();
        return ns::Handle { (__bridge void*)[(__bridge MTLComputePipelineDescriptor*)m_ptr computeFunction] };
    }

    bool ComputePipelineDescriptor::GetThreadGroupSizeIsMultipleOfThreadExecutionWidth() const
    {
        Validate();
        return [(__bridge MTLComputePipelineDescriptor*)m_ptr threadGroupSizeIsMultipleOfThreadExecutionWidth];
    }

    StageInputOutputDescriptor ComputePipelineDescriptor::GetStageInputDescriptor() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return ns::Handle { (__bridge void*)[(__bridge MTLComputePipelineDescriptor*)m_ptr stageInputDescriptor] };
#else
        return ns::Handle { nullptr };
#endif
    }

    void ComputePipelineDescriptor::SetLabel(const ns::String& label)
    {
        Validate();
        [(__bridge MTLComputePipelineDescriptor*)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
    }

    void ComputePipelineDescriptor::SetComputeFunction(const Function& function)
    {
        Validate();
        [(__bridge MTLComputePipelineDescriptor*)m_ptr setComputeFunction:(__bridge id<MTLFunction>)function.GetPtr()];
    }

    void ComputePipelineDescriptor::SetThreadGroupSizeIsMultipleOfThreadExecutionWidth(bool value)
    {
        Validate();
        [(__bridge MTLComputePipelineDescriptor*)m_ptr setThreadGroupSizeIsMultipleOfThreadExecutionWidth:value];
    }

    void ComputePipelineDescriptor::SetStageInputDescriptor(const StageInputOutputDescriptor& stageInputDescriptor) const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLComputePipelineDescriptor*)m_ptr setStageInputDescriptor:(__bridge MTLStageInputOutputDescriptor*)stageInputDescriptor.GetPtr()];
#endif
    }

    Device ComputePipelineState::GetDevice() const
    {
        Validate();
        return ns::Handle { (__bridge void*)[(__bridge id<MTLComputePipelineState>)m_ptr device] };
    }

    uint32_t ComputePipelineState::GetMaxTotalThreadsPerThreadgroup() const
    {
        Validate();
        return uint32_t([(__bridge id<MTLComputePipelineState>)m_ptr maxTotalThreadsPerThreadgroup]);
    }

    uint32_t ComputePipelineState::GetThreadExecutionWidth() const
    {
        Validate();
        return uint32_t([(__bridge id<MTLComputePipelineState>)m_ptr threadExecutionWidth]);
    }
}
