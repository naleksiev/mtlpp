/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "function_constant_values.hpp"
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
#   include <Metal/MTLFunctionConstantValues.h>
#endif

namespace mtlpp
{
    FunctionConstantValues::FunctionConstantValues() :
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        ns::Object(ns::Handle{ (__bridge void*)[[MTLFunctionConstantValues alloc] init] })
#else
        ns::Object(ns::Handle{ nullptr })
#endif
    {
    }

    void FunctionConstantValues::SetConstantValue(const void* value, DataType type, uint32_t index)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLFunctionConstantValues*)m_ptr setConstantValue:value type:MTLDataType(type) atIndex:index];
#endif
    }

    void FunctionConstantValues::SetConstantValue(const void* value, DataType type, const ns::String& name)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLFunctionConstantValues*)m_ptr setConstantValue:value type:MTLDataType(type) withName:(__bridge NSString*)name.GetPtr()];
#endif
    }

    void FunctionConstantValues::SetConstantValues(const void* value, DataType type, const ns::Range& range)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge MTLFunctionConstantValues*)m_ptr setConstantValues:value type:MTLDataType(type) withRange:NSMakeRange(range.Location, range.Length)];
#endif
    }

    void FunctionConstantValues::Reset()
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return [(__bridge MTLFunctionConstantValues*)m_ptr reset];
#endif
    }
}
