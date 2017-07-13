/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "ns.hpp"
#include <CoreFoundation/CFBase.h>
#include <Foundation/NSString.h>
#include <Foundation/NSError.h>
#include <Foundation/NSArray.h>
#include <cstring>

namespace ns
{
    Object::Object() :
        m_ptr(nullptr)
    {
    }

    Object::Object(const Handle& handle) :
        m_ptr(handle.ptr)
    {
        if (m_ptr)
            CFRetain(m_ptr);
    }

    Object::Object(const Object& rhs) :
        m_ptr(rhs.m_ptr)
    {
        if (m_ptr)
            CFRetain(m_ptr);
    }

#if MTLPP_CONFIG_RVALUE_REFERENCES
    Object::Object(Object&& rhs) :
        m_ptr(rhs.m_ptr)
    {
        rhs.m_ptr = nullptr;
    }
#endif

    Object::~Object()
    {
        if (m_ptr)
            CFRelease(m_ptr);
    }

    Object& Object::operator=(const Object& rhs)
    {
        if (rhs.m_ptr == m_ptr)
            return *this;
        if (rhs.m_ptr)
            CFRetain(rhs.m_ptr);
        if (m_ptr)
            CFRelease(m_ptr);
        m_ptr = rhs.m_ptr;
        return *this;
    }

#if MTLPP_CONFIG_RVALUE_REFERENCES
    Object& Object::operator=(Object&& rhs)
    {
        if (rhs.m_ptr == m_ptr)
            return *this;
        if (m_ptr)
            CFRelease(m_ptr);
        m_ptr = rhs.m_ptr;
        rhs.m_ptr = nullptr;
        return *this;
    }
#endif

    uint32_t ArrayBase::GetSize() const
    {
        Validate();
        return uint32_t([(__bridge NSArray*)m_ptr count]);
    }

    void* ArrayBase::GetItem(uint32_t index) const
    {
        Validate();
        return (__bridge void*)[(__bridge NSArray*)m_ptr objectAtIndexedSubscript:index];
    }

    String::String(const char* cstr) :
        Object(Handle{ (__bridge void*)[NSString stringWithUTF8String:cstr] })
    {
    }

    const char* String::GetCStr() const
    {
        Validate();
        return [(__bridge NSString*)m_ptr cStringUsingEncoding:NSUTF8StringEncoding];
    }

    uint32_t String::GetLength() const
    {
        Validate();
        return uint32_t([(__bridge NSString*)m_ptr length]);
    }

    Error::Error() :
        Object(Handle{ (__bridge void*)[[NSError alloc] init] })
    {

    }

    String Error::GetDomain() const
    {
        Validate();
        return Handle{ (__bridge void*)[(__bridge NSError*)m_ptr domain] };
    }

    uint32_t Error::GetCode() const
    {
        Validate();
        return uint32_t([(__bridge NSError*)m_ptr code]);
    }

    //@property (readonly, copy) NSDictionary *userInfo;

    String Error::GetLocalizedDescription() const
    {
        Validate();
        return Handle{ (__bridge void*)[(__bridge NSError*)m_ptr localizedDescription] };
    }

    String Error::GetLocalizedFailureReason() const
    {
        Validate();
        return Handle{ (__bridge void*)[(__bridge NSError*)m_ptr localizedFailureReason] };
    }

    String Error::GetLocalizedRecoverySuggestion() const
    {
        Validate();
        return Handle{ (__bridge void*)[(__bridge NSError*)m_ptr localizedRecoverySuggestion] };
    }

    String Error::GetLocalizedRecoveryOptions() const
    {
        Validate();
        return Handle{ (__bridge void*)[(__bridge NSError*)m_ptr localizedRecoveryOptions] };
    }

    //@property (nullable, readonly, strong) id recoveryAttempter;

    String Error::GetHelpAnchor() const
    {
        Validate();
        return Handle{ (__bridge void*)[(__bridge NSError*)m_ptr helpAnchor] };
    }
}
