/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"
#include "argument.hpp"

namespace mtlpp
{
    class FunctionConstantValues : public ns::Object
    {
    public:
        FunctionConstantValues();
        FunctionConstantValues(const ns::Handle& handle) : ns::Object(handle) { }

        void SetConstantValue(const void* value, DataType type, uint32_t index);
        void SetConstantValue(const void* value, DataType type, const ns::String& name);
        void SetConstantValues(const void* value, DataType type, const ns::Range& range);

        void Reset();
    }
    MTLPP_AVAILABLE(10_12, 10_0);
}
