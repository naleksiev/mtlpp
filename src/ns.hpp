/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"

namespace ns
{
    struct Handle
    {
        const void* ptr;
    };

    class Object
    {
    public:
        inline const void* GetPtr() const { return m_ptr; }

        inline operator bool() const { return m_ptr != nullptr; }

    protected:
        Object();
        Object(const Handle& handle);
        Object(const Object& rhs);
#if MTLPP_CONFIG_RVALUE_REFERENCES
        Object(Object&& rhs);
#endif
        virtual ~Object();

        Object& operator=(const Object& rhs);
#if MTLPP_CONFIG_RVALUE_REFERENCES
        Object& operator=(Object&& rhs);
#endif

        inline void Validate() const
        {
#if MTLPP_CONFIG_VALIDATE
            assert(m_ptr);
#endif
        }

        const void* m_ptr = nullptr;
    };

    struct Range
    {
        inline Range(uint32_t location, uint32_t length) :
            Location(location),
            Length(length)
        { }

        uint32_t Location;
        uint32_t Length;
    };

    class ArrayBase : public Object
    {
    public:
        ArrayBase() { }
        ArrayBase(const Handle& handle) : Object(handle) { }

        uint32_t GetSize() const;

    protected:
        void* GetItem(uint32_t index) const;
    };

    template<typename T>
    class Array : public ArrayBase
    {
    public:
        Array() { }
        Array(const Handle& handle) : ArrayBase(handle) { }

        const T operator[](uint32_t index) const
        {
            return Handle{ GetItem(index) };
        }

        T operator[](uint32_t index)
        {
            return Handle{ GetItem(index) };
        }
    };

    class DictionaryBase : public Object
    {
    public:
        DictionaryBase() { }
        DictionaryBase(const Handle& handle) : Object(handle) { }

    protected:

    };

    template<typename KeyT, typename ValueT>
    class Dictionary : public DictionaryBase
    {
    public:
        Dictionary() { }
        Dictionary(const Handle& handle) : DictionaryBase(handle) { }
    };

    class String : public Object
    {
    public:
        String() { }
        String(const Handle& handle) : Object(handle) { }
        String(const char* cstr);

        const char* GetCStr() const;
        uint32_t    GetLength() const;
    };

    class Error : public Object
    {
    public:
        Error();
        Error(const Handle& handle) : Object(handle) { }

        String   GetDomain() const;
        uint32_t GetCode() const;
        //@property (readonly, copy) NSDictionary *userInfo;
        String   GetLocalizedDescription() const;
        String   GetLocalizedFailureReason() const;
        String   GetLocalizedRecoverySuggestion() const;
        String   GetLocalizedRecoveryOptions() const;
        //@property (nullable, readonly, strong) id recoveryAttempter;
        String   GetHelpAnchor() const;
    };
}
