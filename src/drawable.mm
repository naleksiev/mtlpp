/*
 * Copyright 2016 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "drawable.hpp"
#include <Metal/MTLDrawable.h>

namespace mtlpp
{
    void Drawable::Present()
    {
        Validate();
        [(__bridge id<MTLDrawable>)m_ptr present];
    }

    void Drawable::Present(double presentationTime)
    {
        Validate();
        [(__bridge id<MTLDrawable>)m_ptr presentAtTime:presentationTime];
    }
}
