/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"

namespace mtlpp
{
    enum class PixelFormat
    {
        Invalid                                            = 0,

        A8Unorm                                            = 1,

        R8Unorm                                            = 10,
        R8Unorm_sRGB          MTLPP_AVAILABLE_IOS(8_0)     = 11,

        R8Snorm                                            = 12,
        R8Uint                                             = 13,
        R8Sint                                             = 14,

        R16Unorm                                           = 20,
        R16Snorm                                           = 22,
        R16Uint                                            = 23,
        R16Sint                                            = 24,
        R16Float                                           = 25,

        RG8Unorm                                           = 30,
        RG8Unorm_sRGB         MTLPP_AVAILABLE_IOS(8_0)     = 31,
        RG8Snorm                                           = 32,
        RG8Uint                                            = 33,
        RG8Sint                                            = 34,

        B5G6R5Unorm           MTLPP_AVAILABLE_IOS(8_0)     = 40,
        A1BGR5Unorm           MTLPP_AVAILABLE_IOS(8_0)     = 41,
        ABGR4Unorm            MTLPP_AVAILABLE_IOS(8_0)     = 42,
        BGR5A1Unorm           MTLPP_AVAILABLE_IOS(8_0)     = 43,

        R32Uint                                            = 53,
        R32Sint                                            = 54,
        R32Float                                           = 55,

        RG16Unorm                                          = 60,
        RG16Snorm                                          = 62,
        RG16Uint                                           = 63,
        RG16Sint                                           = 64,
        RG16Float                                          = 65,

        RGBA8Unorm                                         = 70,
        RGBA8Unorm_sRGB                                    = 71,
        RGBA8Snorm                                         = 72,
        RGBA8Uint                                          = 73,
        RGBA8Sint                                          = 74,

        BGRA8Unorm                                         = 80,
        BGRA8Unorm_sRGB                                    = 81,

        RGB10A2Unorm                                       = 90,
        RGB10A2Uint                                        = 91,

        RG11B10Float                                       = 92,
        RGB9E5Float                                        = 93,

        BGR10_XR              MTLPP_AVAILABLE_IOS(10_0)    = 554,
        BGR10_XR_sRGB         MTLPP_AVAILABLE_IOS(10_0)    = 555,


        RG32Uint                                           = 103,
        RG32Sint                                           = 104,
        RG32Float                                          = 105,

        RGBA16Unorm                                        = 110,
        RGBA16Snorm                                        = 112,
        RGBA16Uint                                         = 113,
        RGBA16Sint                                         = 114,
        RGBA16Float                                        = 115,

        BGRA10_XR             MTLPP_AVAILABLE_IOS(10_0)    = 552,
        BGRA10_XR_sRGB        MTLPP_AVAILABLE_IOS(10_0)    = 553,

        RGBA32Uint                                         = 123,
        RGBA32Sint                                         = 124,
        RGBA32Float                                        = 125,

        BC1_RGBA              MTLPP_AVAILABLE_MAC(10_11)   = 130,
        BC1_RGBA_sRGB         MTLPP_AVAILABLE_MAC(10_11)   = 131,
        BC2_RGBA              MTLPP_AVAILABLE_MAC(10_11)   = 132,
        BC2_RGBA_sRGB         MTLPP_AVAILABLE_MAC(10_11)   = 133,
        BC3_RGBA              MTLPP_AVAILABLE_MAC(10_11)   = 134,
        BC3_RGBA_sRGB         MTLPP_AVAILABLE_MAC(10_11)   = 135,

        BC4_RUnorm            MTLPP_AVAILABLE_MAC(10_11)   = 140,
        BC4_RSnorm            MTLPP_AVAILABLE_MAC(10_11)   = 141,
        BC5_RGUnorm           MTLPP_AVAILABLE_MAC(10_11)   = 142,
        BC5_RGSnorm           MTLPP_AVAILABLE_MAC(10_11)   = 143,

        BC6H_RGBFloat         MTLPP_AVAILABLE_MAC(10_11)   = 150,
        BC6H_RGBUfloat        MTLPP_AVAILABLE_MAC(10_11)   = 151,
        BC7_RGBAUnorm         MTLPP_AVAILABLE_MAC(10_11)   = 152,
        BC7_RGBAUnorm_sRGB    MTLPP_AVAILABLE_MAC(10_11)   = 153,

        PVRTC_RGB_2BPP        MTLPP_AVAILABLE_IOS(8_0)     = 160,
        PVRTC_RGB_2BPP_sRGB   MTLPP_AVAILABLE_IOS(8_0)     = 161,
        PVRTC_RGB_4BPP        MTLPP_AVAILABLE_IOS(8_0)     = 162,
        PVRTC_RGB_4BPP_sRGB   MTLPP_AVAILABLE_IOS(8_0)     = 163,
        PVRTC_RGBA_2BPP       MTLPP_AVAILABLE_IOS(8_0)     = 164,
        PVRTC_RGBA_2BPP_sRGB  MTLPP_AVAILABLE_IOS(8_0)     = 165,
        PVRTC_RGBA_4BPP       MTLPP_AVAILABLE_IOS(8_0)     = 166,
        PVRTC_RGBA_4BPP_sRGB  MTLPP_AVAILABLE_IOS(8_0)     = 167,

        EAC_R11Unorm          MTLPP_AVAILABLE_IOS(8_0)     = 170,
        EAC_R11Snorm          MTLPP_AVAILABLE_IOS(8_0)     = 172,
        EAC_RG11Unorm         MTLPP_AVAILABLE_IOS(8_0)     = 174,
        EAC_RG11Snorm         MTLPP_AVAILABLE_IOS(8_0)     = 176,
        EAC_RGBA8             MTLPP_AVAILABLE_IOS(8_0)     = 178,
        EAC_RGBA8_sRGB        MTLPP_AVAILABLE_IOS(8_0)     = 179,

        ETC2_RGB8             MTLPP_AVAILABLE_IOS(8_0)     = 180,
        ETC2_RGB8_sRGB        MTLPP_AVAILABLE_IOS(8_0)     = 181,
        ETC2_RGB8A1           MTLPP_AVAILABLE_IOS(8_0)     = 182,
        ETC2_RGB8A1_sRGB      MTLPP_AVAILABLE_IOS(8_0)     = 183,

        ASTC_4x4_sRGB         MTLPP_AVAILABLE_IOS(8_0)     = 186,
        ASTC_5x4_sRGB         MTLPP_AVAILABLE_IOS(8_0)     = 187,
        ASTC_5x5_sRGB         MTLPP_AVAILABLE_IOS(8_0)     = 188,
        ASTC_6x5_sRGB         MTLPP_AVAILABLE_IOS(8_0)     = 189,
        ASTC_6x6_sRGB         MTLPP_AVAILABLE_IOS(8_0)     = 190,
        ASTC_8x5_sRGB         MTLPP_AVAILABLE_IOS(8_0)     = 192,
        ASTC_8x6_sRGB         MTLPP_AVAILABLE_IOS(8_0)     = 193,
        ASTC_8x8_sRGB         MTLPP_AVAILABLE_IOS(8_0)     = 194,
        ASTC_10x5_sRGB        MTLPP_AVAILABLE_IOS(8_0)     = 195,
        ASTC_10x6_sRGB        MTLPP_AVAILABLE_IOS(8_0)     = 196,
        ASTC_10x8_sRGB        MTLPP_AVAILABLE_IOS(8_0)     = 197,
        ASTC_10x10_sRGB       MTLPP_AVAILABLE_IOS(8_0)     = 198,
        ASTC_12x10_sRGB       MTLPP_AVAILABLE_IOS(8_0)     = 199,
        ASTC_12x12_sRGB       MTLPP_AVAILABLE_IOS(8_0)     = 200,

        ASTC_4x4_LDR          MTLPP_AVAILABLE_IOS(8_0)     = 204,
        ASTC_5x4_LDR          MTLPP_AVAILABLE_IOS(8_0)     = 205,
        ASTC_5x5_LDR          MTLPP_AVAILABLE_IOS(8_0)     = 206,
        ASTC_6x5_LDR          MTLPP_AVAILABLE_IOS(8_0)     = 207,
        ASTC_6x6_LDR          MTLPP_AVAILABLE_IOS(8_0)     = 208,
        ASTC_8x5_LDR          MTLPP_AVAILABLE_IOS(8_0)     = 210,
        ASTC_8x6_LDR          MTLPP_AVAILABLE_IOS(8_0)     = 211,
        ASTC_8x8_LDR          MTLPP_AVAILABLE_IOS(8_0)     = 212,
        ASTC_10x5_LDR         MTLPP_AVAILABLE_IOS(8_0)     = 213,
        ASTC_10x6_LDR         MTLPP_AVAILABLE_IOS(8_0)     = 214,
        ASTC_10x8_LDR         MTLPP_AVAILABLE_IOS(8_0)     = 215,
        ASTC_10x10_LDR        MTLPP_AVAILABLE_IOS(8_0)     = 216,
        ASTC_12x10_LDR        MTLPP_AVAILABLE_IOS(8_0)     = 217,
        ASTC_12x12_LDR        MTLPP_AVAILABLE_IOS(8_0)     = 218,

        GBGR422                                            = 240,

        BGRG422                                            = 241,

        Depth16Unorm          MTLPP_AVAILABLE_MAC(10_12)   = 250,
        Depth32Float                                       = 252,

        Stencil8                                           = 253,

        Depth24Unorm_Stencil8 MTLPP_AVAILABLE_MAC(10_11)   = 255,
        Depth32Float_Stencil8 MTLPP_AVAILABLE(10_11, 9_0)  = 260,

        X32_Stencil8          MTLPP_AVAILABLE(10_12, 10_0) = 261,
        X24_Stencil8          MTLPP_AVAILABLE_MAC(10_12)   = 262,
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}

