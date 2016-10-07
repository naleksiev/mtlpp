/*
 * Copyright 2016 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "function_constant_values.hpp"
#include <Metal/MTLFunctionConstantValues.h>

namespace mtlpp
{
    FunctionConstantValues::FunctionConstantValues() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLFunctionConstantValues alloc] init] })
    {
    }

    void FunctionConstantValues::SetConstantValue(const void* value, DataType type, uint32_t index)
    {
        Validate();
        [(__bridge MTLFunctionConstantValues*)m_ptr setConstantValue:value type:MTLDataType(type) atIndex:index];
    }

    void FunctionConstantValues::SetConstantValue(const void* value, DataType type, const ns::String& name)
    {
        Validate();
        [(__bridge MTLFunctionConstantValues*)m_ptr setConstantValue:value type:MTLDataType(type) withName:(__bridge NSString*)name.GetPtr()];
    }

    void FunctionConstantValues::SetConstantValues(const void* value, DataType type, const ns::Range& range)
    {
        Validate();
        [(__bridge MTLFunctionConstantValues*)m_ptr setConstantValues:value type:MTLDataType(type) withRange:NSMakeRange(range.Location, range.Length)];
    }

    void FunctionConstantValues::Reset()
    {
        Validate();
        return [(__bridge MTLFunctionConstantValues*)m_ptr reset];
    }
}
