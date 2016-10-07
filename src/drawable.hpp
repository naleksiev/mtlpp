/*
 * Copyright 2016 Nikolay Aleksiev. All rights reserved.
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

        void Present();
        void Present(double presentationTime);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}

