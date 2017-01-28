/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"
#include "device.hpp"


namespace mtlpp
{
    class Fence : public ns::Object
    {
    public:
        Fence() { }
        Fence(const ns::Handle& handle) : ns::Object(handle) { }

        Texture    GetDevice() const;
        ns::String GetLabel() const;

        void SetLabel(const ns::String& label);
    }
    MTLPP_AVAILABLE(NA, 10_0);
}
