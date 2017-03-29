/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "drawable.hpp"
#include <Metal/MTLDrawable.h>

namespace mtlpp
{
    double Drawable::GetPresentedTime() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_3)
        return [(__bridge id<MTLDrawable>)m_ptr presentedTime];
#else
        return 0.0;
#endif
    }

    uint64_t Drawable::GetDrawableID() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_3)
        return [(__bridge id<MTLDrawable>)m_ptr drawableID];
#else
        return 0;
#endif
    }

    void Drawable::Present()
    {
        Validate();
        [(__bridge id<MTLDrawable>)m_ptr present];
    }

    void Drawable::PresentAtTime(double presentationTime)
    {
        Validate();
        [(__bridge id<MTLDrawable>)m_ptr presentAtTime:presentationTime];
    }

    void Drawable::PresentAfterMinimumDuration(double duration)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_3)
        [(__bridge id<MTLDrawable>)m_ptr presentAfterMinimumDuration:duration];
#endif
    }

    void Drawable::AddPresentedHandler(std::function<void(const Drawable&)> handler)
    {
        Validate();
#if MTLPP_IS_AVAILABLE_IOS(10_3)
        [(__bridge id<MTLDrawable>)m_ptr addPresentedHandler:^(id <MTLDrawable> mtlDrawable){
            Drawable drawable(ns::Handle{ (__bridge void*)mtlDrawable });
            handler(drawable);
        }];
#endif
    }

}
