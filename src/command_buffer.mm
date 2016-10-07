/*
 * Copyright 2016 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "command_buffer.hpp"
#include "command_queue.hpp"
#include "drawable.hpp"
#include "blit_command_encoder.hpp"
#include "render_command_encoder.hpp"
#include "compute_command_encoder.hpp"
#include "parallel_render_command_encoder.hpp"
#include "render_pass.hpp"

#include <Metal/MTLCommandBuffer.h>

namespace mtlpp
{
    Device CommandBuffer::GetDevice() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLCommandBuffer>)m_ptr device] };
    }

    CommandQueue CommandBuffer::GetCommandQueue() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLCommandBuffer>)m_ptr commandQueue] };
    }

    bool CommandBuffer::GetRetainedReferences() const
    {
        Validate();
        return [(__bridge id<MTLCommandBuffer>)m_ptr retainedReferences];
    }

    ns::String CommandBuffer::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLCommandBuffer>)m_ptr label] };
    }

    CommandBufferStatus CommandBuffer::GetStatus() const
    {
        Validate();
        return CommandBufferStatus([(__bridge id<MTLCommandBuffer>)m_ptr status]);
    }

    ns::Error CommandBuffer::GetError() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLCommandBuffer>)m_ptr error] };
    }

    void CommandBuffer::SetLabel(const ns::String& label)
    {
        Validate();
        [(__bridge id<MTLCommandBuffer>)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
    }

    void CommandBuffer::Enqueue()
    {
        Validate();
        [(__bridge id<MTLCommandBuffer>)m_ptr enqueue];
    }

    void CommandBuffer::Commit()
    {
        Validate();
        [(__bridge id<MTLCommandBuffer>)m_ptr commit];
    }

    void CommandBuffer::AddScheduledHandler(std::function<void(const CommandBuffer&)> handler)
    {
        Validate();
        [(__bridge id<MTLCommandBuffer>)m_ptr addScheduledHandler:^(id <MTLCommandBuffer> mtlCommandBuffer){
            CommandBuffer commandBuffer(ns::Handle{ (__bridge void*)mtlCommandBuffer });
            handler(commandBuffer);
        }];
    }

    void CommandBuffer::AddCompletedHandler(std::function<void(const CommandBuffer&)> handler)
    {
        Validate();
        [(__bridge id<MTLCommandBuffer>)m_ptr addCompletedHandler:^(id <MTLCommandBuffer> mtlCommandBuffer){
            CommandBuffer commandBuffer(ns::Handle{ (__bridge void*)mtlCommandBuffer });
            handler(commandBuffer);
        }];
    }

    void CommandBuffer::Present(const Drawable& drawable)
    {
        Validate();
        [(__bridge id<MTLCommandBuffer>)m_ptr presentDrawable:(__bridge id<MTLDrawable>)drawable.GetPtr()];
    }

    void CommandBuffer::Present(const Drawable& drawable, double presentationTime)
    {
        Validate();
        [(__bridge id<MTLCommandBuffer>)m_ptr presentDrawable:(__bridge id<MTLDrawable>)drawable.GetPtr() atTime:presentationTime];
    }

    void CommandBuffer::WaitUntilScheduled()
    {
        Validate();
        [(__bridge id<MTLCommandBuffer>)m_ptr waitUntilScheduled];
    }

    void CommandBuffer::WaitUntilCompleted()
    {
        Validate();
        [(__bridge id<MTLCommandBuffer>)m_ptr waitUntilCompleted];
    }

    BlitCommandEncoder CommandBuffer::BlitCommandEncoder()
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLCommandBuffer>)m_ptr blitCommandEncoder] };
    }

    RenderCommandEncoder CommandBuffer::RenderCommandEncoder(const RenderPassDescriptor& renderPassDescriptor)
    {
        Validate();
        MTLRenderPassDescriptor* mtlRenderPassDescriptor = (__bridge MTLRenderPassDescriptor*)renderPassDescriptor.GetPtr();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLCommandBuffer>)m_ptr renderCommandEncoderWithDescriptor:mtlRenderPassDescriptor] };
    }

    ComputeCommandEncoder CommandBuffer::ComputeCommandEncoder()
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLCommandBuffer>)m_ptr computeCommandEncoder] };
    }

    ParallelRenderCommandEncoder CommandBuffer::ParallelRenderCommandEncoder(const RenderPassDescriptor& renderPassDescriptor)
    {
        Validate();
        MTLRenderPassDescriptor* mtlRenderPassDescriptor = (__bridge MTLRenderPassDescriptor*)renderPassDescriptor.GetPtr();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLCommandBuffer>)m_ptr parallelRenderCommandEncoderWithDescriptor:mtlRenderPassDescriptor] };
    }
}
