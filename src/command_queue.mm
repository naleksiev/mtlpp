/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "command_queue.hpp"
#include "command_buffer.hpp"
#include "device.hpp"
#include <Metal/MTLCommandQueue.h>

namespace mtlpp
{
    ns::String CommandQueue::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLCommandQueue>)m_ptr label] };
    }

    Device CommandQueue::GetDevice() const
    {
        Validate();
        return ns::Handle { (__bridge void*)[(__bridge id<MTLCommandQueue>)m_ptr device] };
    }

    void CommandQueue::SetLabel(const ns::String& label)
    {
        Validate();
        [(__bridge id<MTLCommandQueue>)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
    }

    CommandBuffer CommandQueue::CommandBufferWithUnretainedReferences()
    {
        Validate();
        return ns::Handle { (__bridge void*)[(__bridge id<MTLCommandQueue>)m_ptr commandBufferWithUnretainedReferences] };
    }

    CommandBuffer CommandQueue::CommandBuffer()
    {
        Validate();
        return ns::Handle { (__bridge void*)[(__bridge id<MTLCommandQueue>)m_ptr commandBuffer] };
    }

    void CommandQueue::InsertDebugCaptureBoundary()
    {
        Validate();
        [(__bridge id<MTLCommandQueue>)m_ptr insertDebugCaptureBoundary];
    }
}
