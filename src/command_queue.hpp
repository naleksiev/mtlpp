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
    class CommandBuffer;

    class CommandQueue : public ns::Object
    {
    public:
        CommandQueue() { }
        CommandQueue(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String GetLabel() const;
        Device     GetDevice() const;

        void SetLabel(const ns::String& label);

        class CommandBuffer CommandBufferWithUnretainedReferences();
        class CommandBuffer CommandBuffer();
        void                InsertDebugCaptureBoundary();
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
