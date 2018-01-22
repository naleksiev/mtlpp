/*
 * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved.
 * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE
 */

#include "library.hpp"
#include "device.hpp"
#include "function_constant_values.hpp"
#include <Metal/MTLLibrary.h>

namespace mtlpp
{
    VertexAttribute::VertexAttribute() :
        ns::Object(ns::Handle{ (__bridge void*)[[MTLVertexAttribute alloc] init] })
    {
    }

    ns::String VertexAttribute::GetName() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLVertexAttribute*)m_ptr name] };
    }

    uint32_t VertexAttribute::GetAttributeIndex() const
    {
        Validate();
        return uint32_t([(__bridge MTLVertexAttribute*)m_ptr attributeIndex]);
    }

    DataType VertexAttribute::GetAttributeType() const
    {
        Validate();
        return DataType([(__bridge MTLVertexAttribute*)m_ptr attributeType]);
    }

    bool VertexAttribute::IsActive() const
    {
        Validate();
        return [(__bridge MTLVertexAttribute*)m_ptr isActive];
    }

    bool VertexAttribute::IsPatchData() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return [(__bridge MTLVertexAttribute*)m_ptr isActive];
#else
        return false;
#endif
    }

    bool VertexAttribute::IsPatchControlPointData() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return [(__bridge MTLVertexAttribute*)m_ptr isActive];
#else
        return false;
#endif
    }

    Attribute::Attribute() :
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        ns::Object(ns::Handle{ (__bridge void*)[[MTLAttribute alloc] init] })
#else
        ns::Object(ns::Handle{ nullptr })
#endif
    {
    }

    ns::String Attribute::GetName() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return ns::Handle{ (__bridge void*)[(__bridge MTLAttribute*)m_ptr name] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    uint32_t Attribute::GetAttributeIndex() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return uint32_t([(__bridge MTLAttribute*)m_ptr attributeIndex]);
#else
        return 0;
#endif
    }

    DataType Attribute::GetAttributeType() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return DataType([(__bridge MTLAttribute*)m_ptr attributeType]);
#else
        return DataType(0);
#endif
    }

    bool Attribute::IsActive() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return [(__bridge MTLAttribute*)m_ptr isActive];
#else
        return false;
#endif
    }

    bool Attribute::IsPatchData() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return [(__bridge MTLAttribute*)m_ptr isActive];
#else
        return false;
#endif
    }

    bool Attribute::IsPatchControlPointData() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return [(__bridge MTLAttribute*)m_ptr isActive];
#else
        return false;
#endif
    }

    FunctionConstant::FunctionConstant() :
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        ns::Object(ns::Handle{ (__bridge void*)[[MTLFunctionConstant alloc] init] })
#else
        ns::Object(ns::Handle{ nullptr })
#endif
    {
    }

    ns::String FunctionConstant::GetName() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return ns::Handle{ (__bridge void*)[(__bridge MTLFunctionConstant*)m_ptr name] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    DataType FunctionConstant::GetType() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return DataType([(__bridge MTLFunctionConstant*)m_ptr type]);
#else
        return DataType(0);
#endif
    }

    uint32_t FunctionConstant::GetIndex() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return uint32_t([(__bridge MTLFunctionConstant*)m_ptr index]);
#else
        return 0;
#endif
    }

    bool FunctionConstant::IsRequired() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return [(__bridge MTLFunctionConstant*)m_ptr required];
#else
        return false;
#endif
    }

    ns::String Function::GetLabel() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLFunction>)m_ptr label] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    Device Function::GetDevice() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLFunction>)m_ptr device] };
    }

    FunctionType Function::GetFunctionType() const
    {
        Validate();
        return FunctionType([(__bridge id<MTLFunction>)m_ptr functionType]);
    }

    PatchType Function::GetPatchType() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return PatchType([(__bridge id<MTLFunction>)m_ptr patchType]);
#else
        return PatchType(0);
#endif
    }

    int32_t Function::GetPatchControlPointCount() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return int32_t([(__bridge id<MTLFunction>)m_ptr patchControlPointCount]);
#else
        return 0;
#endif
    }

    const ns::Array<VertexAttribute> Function::GetVertexAttributes() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLFunction>)m_ptr vertexAttributes] };
    }

    const ns::Array<Attribute> Function::GetStageInputAttributes() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLFunction>)m_ptr stageInputAttributes] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    ns::String Function::GetName() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLFunction>)m_ptr name] };
    }

    ns::Dictionary<ns::String, FunctionConstant> Function::GetFunctionConstants() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLFunction>)m_ptr functionConstantsDictionary] };
#else
        return ns::Handle{ nullptr };
#endif
    }

    void Function::SetLabel(const ns::String& label)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge id<MTLFunction>)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
#endif
    }

    ns::Dictionary<ns::String, ns::String> CompileOptions::GetPreprocessorMacros() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge MTLCompileOptions*)m_ptr preprocessorMacros] };
    }

    bool CompileOptions::IsFastMathEnabled() const
    {
        Validate();
        return [(__bridge MTLCompileOptions*)m_ptr fastMathEnabled];
    }

    LanguageVersion CompileOptions::GetLanguageVersion() const
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_11, 9_0)
        return LanguageVersion([(__bridge MTLCompileOptions*)m_ptr languageVersion]);
#else
        return LanguageVersion::Version1_0;
#endif
    }

    void CompileOptions::SetFastMathEnabled(bool fastMathEnabled)
    {
        Validate();
        [(__bridge MTLCompileOptions*)m_ptr setFastMathEnabled:fastMathEnabled];
    }

    void CompileOptions::SetFastMathEnabled(LanguageVersion languageVersion)
    {
        Validate();
        [(__bridge MTLCompileOptions*)m_ptr setFastMathEnabled:MTLLanguageVersion(languageVersion)];
    }

    ns::String Library::GetLabel() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLLibrary>)m_ptr label] };
    }

    void Library::SetLabel(const ns::String& label)
    {
        Validate();
        [(__bridge id<MTLLibrary>)m_ptr setLabel:(__bridge NSString*)label.GetPtr()];
    }

    ns::Array<ns::String> Library::GetFunctionNames() const
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLLibrary>)m_ptr functionNames] };
    }

    Function Library::NewFunction(const ns::String& functionName)
    {
        Validate();
        return ns::Handle{ (__bridge void*)[(__bridge id<MTLLibrary>)m_ptr newFunctionWithName:(__bridge NSString*)functionName.GetPtr()] };
    }

    Function Library::NewFunction(const ns::String& functionName, const FunctionConstantValues& constantValues, ns::Error* error)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        // Error
        NSError* nsError = NULL;
        NSError** nsErrorPtr = error ? &nsError : nullptr;

        id<MTLFunction> function = [(__bridge id<MTLLibrary>)m_ptr newFunctionWithName:(__bridge NSString*)functionName.GetPtr()
                                                                        constantValues:(__bridge MTLFunctionConstantValues*)constantValues.GetPtr()
                                                                                 error:nsErrorPtr];

        // Error update
        if (error && nsError){
            *error = ns::Handle{ (__bridge void*)nsError };
        }

        return ns::Handle{ (__bridge void*)function };
#else
        return ns::Handle{ nullptr };
#endif
    }

    void Library::NewFunction(const ns::String& functionName, const FunctionConstantValues& constantValues, std::function<void(const Function&, const ns::Error&)> completionHandler)
    {
        Validate();
#if MTLPP_IS_AVAILABLE(10_12, 10_0)
        [(__bridge id<MTLLibrary>)m_ptr
             newFunctionWithName:(__bridge NSString*)functionName.GetPtr()
             constantValues:(__bridge MTLFunctionConstantValues*)constantValues.GetPtr()
             completionHandler:^(id <MTLFunction> mtlFunction, NSError* error){
                 completionHandler(ns::Handle{ (__bridge void*)mtlFunction }, ns::Handle{ (__bridge void*)error });
             }];
#endif
    }

}
