/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "texture.hpp"

namespace mtlpp
{
    class StructType;
    class ArrayType;

    enum class DataType
    {
        None     = 0,

        Struct   = 1,
        Array    = 2,

        Float    = 3,
        Float2   = 4,
        Float3   = 5,
        Float4   = 6,

        Float2x2 = 7,
        Float2x3 = 8,
        Float2x4 = 9,

        Float3x2 = 10,
        Float3x3 = 11,
        Float3x4 = 12,

        Float4x2 = 13,
        Float4x3 = 14,
        Float4x4 = 15,

        Half     = 16,
        Half2    = 17,
        Half3    = 18,
        Half4    = 19,

        Half2x2  = 20,
        Half2x3  = 21,
        Half2x4  = 22,

        Half3x2  = 23,
        Half3x3  = 24,
        Half3x4  = 25,

        Half4x2  = 26,
        Half4x3  = 27,
        Half4x4  = 28,

        Int      = 29,
        Int2     = 30,
        Int3     = 31,
        Int4     = 32,

        UInt     = 33,
        UInt2    = 34,
        UInt3    = 35,
        UInt4    = 36,

        Short    = 37,
        Short2   = 38,
        Short3   = 39,
        Short4   = 40,

        UShort   = 41,
        UShort2  = 42,
        UShort3  = 43,
        UShort4  = 44,

        Char     = 45,
        Char2    = 46,
        Char3    = 47,
        Char4    = 48,

        UChar    = 49,
        UChar2   = 50,
        UChar3   = 51,
        UChar4   = 52,

        Bool     = 53,
        Bool2    = 54,
        Bool3    = 55,
        Bool4    = 56,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class ArgumentType
    {
        Buffer            = 0,
        ThreadgroupMemory = 1,
        Texture           = 2,
        Sampler           = 3,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class ArgumentAccess
    {
        ReadOnly  = 0,
        ReadWrite = 1,
        WriteOnly = 2,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class StructMember : public ns::Object
    {
    public:
        StructMember();
        StructMember(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String GetName() const;
        uint32_t   GetOffset() const;
        DataType   GetDataType() const;

        StructType GetStructType() const;
        ArrayType  GetArrayType() const;
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class StructType : public ns::Object
    {
    public:
        StructType();
        StructType(const ns::Handle& handle) : ns::Object(handle) { }

        const ns::Array<StructMember> GetMembers() const;
        StructMember                  GetMember(const ns::String& name) const;
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class ArrayType : public ns::Object
    {
    public:
        ArrayType();
        ArrayType(const ns::Handle& handle) : ns::Object(handle) { }

        uint32_t   GetArrayLength() const;
        DataType   GetElementType() const;
        uint32_t   GetStride() const;
        StructType GetElementStructType() const;
        ArrayType  GetElementArrayType() const;
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class Argument : public ns::Object
    {
    public:
        Argument();
        Argument(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String     GetName() const;
        ArgumentType   GetType() const;
        ArgumentAccess GetAccess() const;
        uint32_t       GetIndex() const;

        bool           IsActive() const;

        uint32_t       GetBufferAlignment() const;
        uint32_t       GetBufferDataSize() const;
        DataType       GetBufferDataType() const;
        StructType     GetBufferStructType() const;

        uint32_t       GetThreadgroupMemoryAlignment() const;
        uint32_t       GetThreadgroupMemoryDataSize() const;

        TextureType    GetTextureType() const;
        DataType       GetTextureDataType() const;

        bool           IsDepthTexture() const MTLPP_AVAILABLE(10_12, 10_0);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}

