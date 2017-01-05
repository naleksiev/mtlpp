/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "device.hpp"
#include "argument.hpp"
#include "stage_input_output_descriptor.hpp"

namespace mtlpp
{
    class ComputePipelineReflection : public ns::Object
    {
    public:
        ComputePipelineReflection();
        ComputePipelineReflection(const ns::Handle& handle) : ns::Object(handle) { }

        ns::Array<Argument> GetArguments() const;
    }
    MTLPP_AVAILABLE(10_11, 9_0);

    class ComputePipelineDescriptor : public ns::Object
    {
    public:
        ComputePipelineDescriptor();
        ComputePipelineDescriptor(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String                 GetLabel() const;
        Function                   GetComputeFunction() const;
        bool                       GetThreadGroupSizeIsMultipleOfThreadExecutionWidth() const;
        StageInputOutputDescriptor GetStageInputDescriptor() const MTLPP_AVAILABLE(10_12, 10_0);

        void SetLabel(const ns::String& label);
        void SetComputeFunction(const Function& function);
        void SetThreadGroupSizeIsMultipleOfThreadExecutionWidth(bool value);
        void SetStageInputDescriptor(const StageInputOutputDescriptor& stageInputDescriptor) const MTLPP_AVAILABLE(10_12, 10_0);

        void Reset();
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class ComputePipelineState : public ns::Object
    {
    public:
        ComputePipelineState() { }
        ComputePipelineState(const ns::Handle& handle) : ns::Object(handle) { }

        Device   GetDevice() const;
        uint32_t GetMaxTotalThreadsPerThreadgroup() const;
        uint32_t GetThreadExecutionWidth() const;
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
