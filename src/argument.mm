/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "argument.hpp"
#include <Metal/MTLArgument.h>

namespace mtlpp
{
    StructMember::StructMember() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLStructMember alloc] init] })
    {
    }

    ns::String StructMember::GetName() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLStructMember*)m_ptr name] };
    }

    uint32_t StructMember::GetOffset() const
    {
        Validate();
        return uint32_t([(__bridge MTLStructMember*)m_ptr offset]);
    }

    DataType StructMember::GetDataType() const
    {
        Validate();
        return DataType([(__bridge MTLStructMember*)m_ptr dataType]);
    }

    StructType StructMember::GetStructType() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLStructMember*)m_ptr structType] };
    }

    ArrayType StructMember::GetArrayType() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLStructMember*)m_ptr arrayType] };
    }

    StructType::StructType() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLStructType alloc] init] })
    {
    }

    const ns::Array<StructMember> StructType::GetMembers() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLStructType*)m_ptr members] };
    }

    StructMember StructType::GetMember(const ns::String& name) const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLStructType*)m_ptr memberByName:(__bridge NSString*)name.GetPtr()] };
    }

    ArrayType::ArrayType() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLArrayType alloc] init] })
    {
    }

    uint32_t ArrayType::GetArrayLength() const
    {
        Validate();
        return uint32_t([(__bridge MTLArrayType*)m_ptr arrayLength]);
    }

    DataType ArrayType::GetElementType() const
    {
        Validate();
        return DataType([(__bridge MTLArrayType*)m_ptr elementType]);
    }

    uint32_t ArrayType::GetStride() const
    {
        Validate();
        return uint32_t([(__bridge MTLArrayType*)m_ptr stride]);
    }

    StructType ArrayType::GetElementStructType() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLArrayType*)m_ptr elementStructType] };
    }

    ArrayType ArrayType::GetElementArrayType() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLArrayType*)m_ptr elementArrayType] };
    }

    Argument::Argument() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLArgument alloc] init] })
    {
    }

    ns::String Argument::GetName() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLArgument*)m_ptr name] };
    }

    ArgumentType Argument::GetType() const
    {
        Validate();
        return ArgumentType([(__bridge MTLArgument*)m_ptr type]);
    }

    ArgumentAccess Argument::GetAccess() const
    {
        Validate();
        return ArgumentAccess([(__bridge MTLArgument*)m_ptr access]);
    }

    uint32_t Argument::GetIndex() const
    {
        Validate();
        return uint32_t([(__bridge MTLArgument*)m_ptr index]);
    }

    bool Argument::IsActive() const
    {
        Validate();
        return [(__bridge MTLArgument*)m_ptr isActive];
    }

    uint32_t Argument::GetBufferAlignment() const
    {
        Validate();
        return uint32_t([(__bridge MTLArgument*)m_ptr bufferAlignment]);
    }

    uint32_t Argument::GetBufferDataSize() const
    {
        Validate();
        return uint32_t([(__bridge MTLArgument*)m_ptr bufferDataSize]);
    }

    DataType Argument::GetBufferDataType() const
    {
        Validate();
        return DataType([(__bridge MTLArgument*)m_ptr bufferDataType]);
    }

    StructType Argument::GetBufferStructType() const
    {
        Validate();
        return StructType(ns::Handle { (__bridge void*)[(__bridge MTLArgument*)m_ptr bufferStructType] });
    }

    uint32_t Argument::GetThreadgroupMemoryAlignment() const
    {
        Validate();
        return uint32_t([(__bridge MTLArgument*)m_ptr threadgroupMemoryAlignment]);
    }

    uint32_t Argument::GetThreadgroupMemoryDataSize() const
    {
        Validate();
        return uint32_t([(__bridge MTLArgument*)m_ptr threadgroupMemoryDataSize]);
    }

    TextureType Argument::GetTextureType() const
    {
        Validate();
        return TextureType([(__bridge MTLArgument*)m_ptr textureType]);
    }

    DataType Argument::GetTextureDataType() const
    {
        Validate();
        return DataType([(__bridge MTLArgument*)m_ptr textureDataType]);
    }

    bool Argument::IsDepthTexture() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return [(__bridge MTLArgument*)m_ptr isDepthTexture];
#else
        return false;
#endif
    }
}
