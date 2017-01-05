/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"

namespace mtlpp
{
    struct Origin
    {
        inline Origin(uint32_t x, uint32_t y, uint32_t z) :
            X(x),
            Y(y),
            Z(z)
        { }

        uint32_t X;
        uint32_t Y;
        uint32_t Z;
    };

    struct Size
    {
        inline Size(uint32_t width, uint32_t height, uint32_t depth) :
            Width(width),
            Height(height),
            Depth(depth)
        { }

        uint32_t Width;
        uint32_t Height;
        uint32_t Depth;
    };

    struct Region
    {
        inline Region(uint32_t x, uint32_t width) :
            Origin(x, 0, 0),
            Size(width, 1, 1)
        { }

        inline Region(uint32_t x, uint32_t y, uint32_t width, uint32_t height) :
            Origin(x, y, 0),
            Size(width, height, 1)
        { }

        inline Region(uint32_t x, uint32_t y, uint32_t z, uint32_t width, uint32_t height, uint32_t depth) :
            Origin(x, y, z),
            Size(width, height, depth)
        { }

        Origin Origin;
        Size   Size;
    };
}
