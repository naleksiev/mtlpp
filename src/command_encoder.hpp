/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"

namespace mtlpp
{
    class Device;

    class CommandEncoder : public ns::Object
    {
    public:
        CommandEncoder() { }
        CommandEncoder(const ns::Handle& handle) : ns::Object(handle) { }

        Device     GetDevice() const;
        ns::String GetLabel() const;

        void SetLabel(const ns::String& label);

        void EndEncoding();
        void InsertDebugSignpost(const ns::String& string);
        void PushDebugGroup(const ns::String& string);
        void PopDebugGroup();
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
