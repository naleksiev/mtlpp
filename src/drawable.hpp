/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"

namespace mtlpp
{
    class Drawable : public ns::Object
    {
    public:
        Drawable() { }
        Drawable(const ns::Handle& handle) : ns::Object(handle) { }

        double   GetPresentedTime() const MTLPP_AVAILABLE_IOS(10_3);
        uint64_t GetDrawableID() const MTLPP_AVAILABLE_IOS(10_3);

        void Present();
        void PresentAtTime(double presentationTime);
        void PresentAfterMinimumDuration(double duration) MTLPP_AVAILABLE_IOS(10_3);
        void AddPresentedHandler(std::function<void(const Drawable&)> handler) MTLPP_AVAILABLE_IOS(10_3);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}

