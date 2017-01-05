/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "command_encoder.hpp"
#include "device.hpp"
#include <Metal/MTLCommandEncoder.h>

namespace mtlpp
{
    Device CommandEncoder::GetDevice() const
    {
        Validate();
        return ns::Handle { (__bridge void*)[(__bridge id<MTLCommandEncoder>)m_ptr device] };
    }

    ns::String CommandEncoder::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLCommandEncoder>)m_ptr label] };
    }

    void CommandEncoder::SetLabel(const ns::String& label)
    {
        Validate();
        [(__bridge id<MTLCommandEncoder>)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
    }

    void CommandEncoder::EndEncoding()
    {
        Validate();
        [(__bridge id<MTLCommandEncoder>)m_ptr endEncoding];
    }

    void CommandEncoder::InsertDebugSignpost(const ns::String& string)
    {
        Validate();
        [(__bridge id<MTLCommandEncoder>)m_ptr insertDebugSignpost:(__bridge NSString*)string.GetPtr()];
    }

    void CommandEncoder::PushDebugGroup(const ns::String& string)
    {
        Validate();
        [(__bridge id<MTLCommandEncoder>)m_ptr pushDebugGroup:(__bridge NSString*)string.GetPtr()];
    }

    void CommandEncoder::PopDebugGroup()
    {
        Validate();
        [(__bridge id<MTLCommandEncoder>)m_ptr popDebugGroup];
    }
}
