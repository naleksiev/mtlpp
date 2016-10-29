//
//  GameViewController.mm
//

#import "GameViewController.h"
#import "SharedStructures.h"

#import <simd/simd.h>
#import <ModelIO/ModelIO.h>
#import "mtlpp.hpp"

// The max number of command buffers in flight
static const NSUInteger kMaxInflightBuffers = 3;

// Max API memory buffer size.
static const size_t kMaxBytesPerFrame = 1024*1024;

@implementation GameViewController
{
    // view
    MTKView *_view;
    
    // controller
    dispatch_semaphore_t _inflight_semaphore;
    mtlpp::Buffer _dynamicConstantBuffer;
    uint8_t _constantDataBufferIndex;
    
    // renderer
    mtlpp::Device _device;
    mtlpp::CommandQueue _commandQueue;
    mtlpp::Library _defaultLibrary;
    mtlpp::RenderPipelineState _pipelineState;
    mtlpp::DepthStencilState _depthState;

    // uniforms
    matrix_float4x4 _projectionMatrix;
    matrix_float4x4 _viewMatrix;
    uniforms_t _uniform_buffer;
    float _rotation;
    
    // meshes
    MTKMesh *_boxMesh;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _constantDataBufferIndex = 0;
    _inflight_semaphore = dispatch_semaphore_create(kMaxInflightBuffers);
    
    [self _setupMetal];
    if(_device)
    {
        [self _setupView];
        [self _loadAssets];
        [self _reshape];
    }
    else // Fallback to a blank NSView, an application could also fallback to OpenGL here.
    {
        NSLog(@"Metal is not supported on this device");
        self.view = [[NSView alloc] initWithFrame:self.view.frame];
    }
}

- (void)_setupView
{
    _view = (MTKView *)self.view;
    _view.delegate = self;
    _view.device = (__bridge id<MTLDevice>)_device.GetPtr();
    
    // Setup the render target, choose values based on your app
    _view.sampleCount = 4;
    _view.depthStencilPixelFormat = MTLPixelFormatDepth32Float_Stencil8;
}

- (void)_setupMetal
{
    // Set the view to use the default device
    _device = mtlpp::Device::CreateSystemDefaultDevice();

    // Create a new command queue
    _commandQueue = _device.NewCommandQueue();
    
    // Load all the shader files with a metal file extension in the project
    _defaultLibrary = _device.NewDefaultLibrary();
}

- (void)_loadAssets
{
    // Generate meshes
    MDLMesh *mdl = [MDLMesh newBoxWithDimensions:(vector_float3){2,2,2} segments:(vector_uint3){1,1,1}
                                    geometryType:MDLGeometryTypeTriangles inwardNormals:NO
                                       allocator:[[MTKMeshBufferAllocator alloc] initWithDevice: (__bridge id<MTLDevice>)_device.GetPtr()]];
    
    _boxMesh = [[MTKMesh alloc] initWithMesh:mdl device:(__bridge id<MTLDevice>)_device.GetPtr() error:nil];
    
    // Allocate one region of memory for the uniform buffer
    _dynamicConstantBuffer = _device.NewBuffer(kMaxBytesPerFrame, mtlpp::ResourceOptions::CpuCacheModeDefaultCache);
    _dynamicConstantBuffer.SetLabel("UniformBuffer");
    
    // Load the fragment program into the library
    mtlpp::Function fragmentProgram = _defaultLibrary.NewFunction("lighting_fragment");
    
    // Load the vertex program into the library
    mtlpp::Function vertexProgram = _defaultLibrary.NewFunction("lighting_vertex");
    
    // Create a vertex descriptor from the MTKMesh
    mtlpp::VertexDescriptor vertexDescriptor(ns::Handle{ (__bridge void*)MTKMetalVertexDescriptorFromModelIO(_boxMesh.vertexDescriptor) });
    vertexDescriptor.GetLayouts()[0].SetStepRate(1);
    vertexDescriptor.GetLayouts()[0].SetStepFunction(mtlpp::VertexStepFunction::PerVertex);
    
    // Create a reusable pipeline state
    mtlpp::RenderPipelineDescriptor pipelineStateDescriptor;
    pipelineStateDescriptor.SetLabel("MyPipeline");
    pipelineStateDescriptor.SetSampleCount(uint32_t(_view.sampleCount));
    pipelineStateDescriptor.SetVertexFunction(vertexProgram);
    pipelineStateDescriptor.SetFragmentFunction(fragmentProgram);
    pipelineStateDescriptor.SetVertexDescriptor(vertexDescriptor);
    pipelineStateDescriptor.GetColorAttachments()[0].SetPixelFormat(mtlpp::PixelFormat(_view.colorPixelFormat));
    pipelineStateDescriptor.SetDepthAttachmentPixelFormat(mtlpp::PixelFormat(_view.depthStencilPixelFormat));
    pipelineStateDescriptor.SetStencilAttachmentPixelFormat(mtlpp::PixelFormat(_view.depthStencilPixelFormat));
    
    ns::Error error;
    _pipelineState = _device.NewRenderPipelineState(pipelineStateDescriptor, &error);
    if (!_pipelineState) {
        NSLog(@"Failed to created pipeline state, error %s", error.GetLocalizedDescription().GetCStr());
    }
    
    mtlpp::DepthStencilDescriptor depthStateDesc;
    depthStateDesc.SetDepthCompareFunction(mtlpp::CompareFunction::Less);
    depthStateDesc.SetDepthWriteEnabled(true);
    _depthState = _device.NewDepthStencilState(depthStateDesc);
}

- (void)_render
{
    dispatch_semaphore_wait(_inflight_semaphore, DISPATCH_TIME_FOREVER);
    
    [self _update];

    // Create a new command buffer for each renderpass to the current drawable
    mtlpp::CommandBuffer commandBuffer = _commandQueue.CommandBuffer();
    commandBuffer.SetLabel("MyCommand");

    // Call the view's completion handler which is required by the view since it will signal its semaphore and set up the next buffer
    __block dispatch_semaphore_t block_sema = _inflight_semaphore;
    commandBuffer.AddCompletedHandler(^(const mtlpp::CommandBuffer& buffer) {
        dispatch_semaphore_signal(block_sema);
    });
    
    // Obtain a renderPassDescriptor generated from the view's drawable textures
    mtlpp::RenderPassDescriptor renderPassDescriptor(ns::Handle{ (__bridge void*)_view.currentRenderPassDescriptor});

    if(renderPassDescriptor) // If we have a valid drawable, begin the commands to render into it
    {
        // Create a render command encoder so we can render into something
        mtlpp::RenderCommandEncoder renderEncoder = commandBuffer.RenderCommandEncoder(renderPassDescriptor);
        renderEncoder.SetLabel("MyRenderEncoder");
        renderEncoder.SetDepthStencilState(_depthState);
        
        // Set context state
        renderEncoder.PushDebugGroup("DrawCube");
        renderEncoder.SetRenderPipelineState(_pipelineState);
        renderEncoder.SetVertexBuffer(ns::Handle{ (__bridge void*)_boxMesh.vertexBuffers[0].buffer }, uint32_t(_boxMesh.vertexBuffers[0].offset), 0);
        renderEncoder.SetVertexBuffer(_dynamicConstantBuffer, uint32_t(sizeof(uniforms_t) * _constantDataBufferIndex), 1);
        
        MTKSubmesh* submesh = _boxMesh.submeshes[0];
        // Tell the render context we want to draw our primitives
        renderEncoder.DrawIndexed(mtlpp::PrimitiveType(submesh.primitiveType), uint32_t(submesh.indexCount), mtlpp::IndexType(submesh.indexType), ns::Handle{ (__bridge void*)submesh.indexBuffer.buffer}, uint32_t(submesh.indexBuffer.offset));

        renderEncoder.PopDebugGroup();
        
        // We're done encoding commands
        renderEncoder.EndEncoding();
        
        // Schedule a present once the framebuffer is complete using the current drawable
        commandBuffer.Present(ns::Handle{ (__bridge void*)_view.currentDrawable });
    }

    // The render assumes it can now increment the buffer index and that the previous index won't be touched until we cycle back around to the same index
    _constantDataBufferIndex = (_constantDataBufferIndex + 1) % kMaxInflightBuffers;

    // Finalize rendering here & push the command buffer to the GPU
    commandBuffer.Commit();
}

- (void)_reshape
{
    // When reshape is called, update the view and projection matricies since this means the view orientation or size changed
    float aspect = fabs(self.view.bounds.size.width / self.view.bounds.size.height);
    _projectionMatrix = matrix_from_perspective_fov_aspectLH(65.0f * (M_PI / 180.0f), aspect, 0.1f, 100.0f);
    
    _viewMatrix = matrix_identity_float4x4;
}

- (void)_update
{
    matrix_float4x4 base_model = matrix_multiply(matrix_from_translation(0.0f, 0.0f, 5.0f), matrix_from_rotation(_rotation, 0.0f, 1.0f, 0.0f));
    matrix_float4x4 base_mv = matrix_multiply(_viewMatrix, base_model);
    matrix_float4x4 modelViewMatrix = matrix_multiply(base_mv, matrix_from_rotation(_rotation, 1.0f, 1.0f, 1.0f));
    
    // Load constant buffer data into appropriate buffer at current index
    uniforms_t *uniforms = &((uniforms_t *)_dynamicConstantBuffer.GetContents())[_constantDataBufferIndex];

    uniforms->normal_matrix = matrix_invert(matrix_transpose(modelViewMatrix));
    uniforms->modelview_projection_matrix = matrix_multiply(_projectionMatrix, modelViewMatrix);
    
    _rotation += 0.01f;
}

// Called whenever view changes orientation or layout is changed
- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size
{
    [self _reshape];
}


// Called whenever the view needs to render
- (void)drawInMTKView:(nonnull MTKView *)view
{
    @autoreleasepool {
        [self _render];
    }
}

#pragma mark Utilities

static matrix_float4x4 matrix_from_perspective_fov_aspectLH(const float fovY, const float aspect, const float nearZ, const float farZ)
{
    float yscale = 1.0f / tanf(fovY * 0.5f); // 1 / tan == cot
    float xscale = yscale / aspect;
    float q = farZ / (farZ - nearZ);
    
    matrix_float4x4 m = {
        .columns[0] = { xscale, 0.0f, 0.0f, 0.0f },
        .columns[1] = { 0.0f, yscale, 0.0f, 0.0f },
        .columns[2] = { 0.0f, 0.0f, q, 1.0f },
        .columns[3] = { 0.0f, 0.0f, q * -nearZ, 0.0f }
    };
    
    return m;
}

static matrix_float4x4 matrix_from_translation(float x, float y, float z)
{
    matrix_float4x4 m = matrix_identity_float4x4;
    m.columns[3] = (vector_float4) { x, y, z, 1.0 };
    return m;
}

static matrix_float4x4 matrix_from_rotation(float radians, float x, float y, float z)
{
    vector_float3 v = vector_normalize(((vector_float3){x, y, z}));
    float cos = cosf(radians);
    float cosp = 1.0f - cos;
    float sin = sinf(radians);
    
    matrix_float4x4 m = {
        .columns[0] = {
            cos + cosp * v.x * v.x,
            cosp * v.x * v.y + v.z * sin,
            cosp * v.x * v.z - v.y * sin,
            0.0f,
        },
        
        .columns[1] = {
            cosp * v.x * v.y - v.z * sin,
            cos + cosp * v.y * v.y,
            cosp * v.y * v.z + v.x * sin,
            0.0f,
        },
        
        .columns[2] = {
            cosp * v.x * v.z + v.y * sin,
            cosp * v.y * v.z - v.x * sin,
            cos + cosp * v.z * v.z,
            0.0f,
        },
        
        .columns[3] = { 0.0f, 0.0f, 0.0f, 1.0f
        }
    };
    return m;
}

@end
