/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#pragma once

#include "defines.hpp"
#include "ns.hpp"
#include "argument.hpp"

namespace mtlpp
{
    class Device;
    class FunctionConstantValues;

    enum class PatchType
    {
        None     = 0,
        Triangle = 1,
        Quad     = 2,
    }
    MTLPP_AVAILABLE(10_12, 10_0);

    class VertexAttribute : public ns::Object
    {
    public:
        VertexAttribute();
        VertexAttribute(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String   GetName() const;
        uint32_t     GetAttributeIndex() const;
        DataType     GetAttributeType() const MTLPP_AVAILABLE(10_11, 8_3);
        bool         IsActive() const;
        bool         IsPatchData() const MTLPP_AVAILABLE(10_12, 10_0);
        bool         IsPatchControlPointData() const MTLPP_AVAILABLE(10_12, 10_0);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class Attribute : public ns::Object
    {
    public:
        Attribute();
        Attribute(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String   GetName() const;
        uint32_t     GetAttributeIndex() const;
        DataType     GetAttributeType() const MTLPP_AVAILABLE(10_11, 8_3);
        bool         IsActive() const;
        bool         IsPatchData() const MTLPP_AVAILABLE(10_12, 10_0);
        bool         IsPatchControlPointData() const MTLPP_AVAILABLE(10_12, 10_0);
    }
    MTLPP_AVAILABLE(10_12, 10_0);

    enum class FunctionType
    {
        TypeVertex   = 1,
        TypeFragment = 2,
        TypeKernel   = 3,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class FunctionConstant : public ns::Object
    {
    public:
        FunctionConstant();
        FunctionConstant(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String GetName() const;
        DataType   GetType() const;
        uint32_t   GetIndex() const;
        bool       IsRequired() const;
    }
    MTLPP_AVAILABLE(10_12, 10_0);

    class Function : public ns::Object
    {
    public:
        Function() { }
        Function(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String                                   GetLabel() const MTLPP_AVAILABLE(10_12, 10_0);
        Device                                       GetDevice() const;
        FunctionType                                 GetFunctionType() const;
        PatchType                                    GetPatchType() const MTLPP_AVAILABLE(10_12, 10_0);
        int32_t                                      GetPatchControlPointCount() const MTLPP_AVAILABLE(10_12, 10_0);
        const ns::Array<VertexAttribute>             GetVertexAttributes() const;
        const ns::Array<Attribute>                   GetStageInputAttributes() const MTLPP_AVAILABLE(10_12, 10_0);
        ns::String                                   GetName() const;
        ns::Dictionary<ns::String, FunctionConstant> GetFunctionConstants() const MTLPP_AVAILABLE(10_12, 10_0);

        void SetLabel(const ns::String& label) MTLPP_AVAILABLE(10_12, 10_0);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class LanguageVersion
    {
        Version1_0 MTLPP_AVAILABLE(NA, 9_0)     = (1 << 16),
        Version1_1 MTLPP_AVAILABLE(10_11, 9_0)  = (1 << 16) + 1,
        Version1_2 MTLPP_AVAILABLE(10_12, 10_0) = (1 << 16) + 2,
    }
    MTLPP_AVAILABLE(10_11, 9_0);

    class CompileOptions : public ns::Object
    {
    public:
        CompileOptions();
        CompileOptions(const ns::Handle& handle) : ns::Object(handle) { }

        ns::Dictionary<ns::String, ns::String> GetPreprocessorMacros() const;
        bool                                   IsFastMathEnabled() const;
        LanguageVersion                        GetLanguageVersion() const MTLPP_AVAILABLE(10_11, 9_0);

        void SetFastMathEnabled(bool fastMathEnabled);
        void SetFastMathEnabled(LanguageVersion languageVersion);
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class LibraryError
    {
        Unsupported                                   = 1,
        Internal                                      = 2,
        CompileFailure                                = 3,
        CompileWarning                                = 4,
        FunctionNotFound MTLPP_AVAILABLE(10_12, 10_0) = 5,
        FileNotFound     MTLPP_AVAILABLE(10_12, 10_0) = 6,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    enum class RenderPipelineError
    {
        Internal     = 1,
        Unsupported  = 2,
        InvalidInput = 3,
    }
    MTLPP_AVAILABLE(10_11, 8_0);

    class Library : public ns::Object
    {
    public:
        Library() { }
        Library(const ns::Handle& handle) : ns::Object(handle) { }

        ns::String            GetLabel() const;
        Device                GetDevice() const;
        ns::Array<ns::String> GetFunctionNames() const;

        void SetLabel(const ns::String& label);

        Function NewFunction(const ns::String& functionName);
        Function NewFunction(const ns::String& functionName, const FunctionConstantValues& constantValues, ns::Error* error) MTLPP_AVAILABLE(10_12, 10_0);
        void NewFunction(const ns::String& functionName, const FunctionConstantValues& constantValues, std::function<void(const Function&, const ns::Error&)> completionHandler) MTLPP_AVAILABLE(10_12, 10_0);
    }
    MTLPP_AVAILABLE(10_11, 8_0);
}
