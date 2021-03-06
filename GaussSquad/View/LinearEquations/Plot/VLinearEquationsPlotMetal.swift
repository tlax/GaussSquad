import UIKit
import MetalKit

class VLinearEquationsPlotMetal:MTKView
{
    private var positionBuffer:MTLBuffer
    private weak var controller:CLinearEquationsPlot!
    private var threadgroupCounts:MTLSize
    private var threadgroups:MTLSize
    private let pipelineCompute:MTLComputePipelineState
    private let samplerState:MTLSamplerState
    private let kernelFunction:MTLFunction
    private let commandQueue:MTLCommandQueue
    private let pipelineState:MTLRenderPipelineState
    
    init?(controller:CLinearEquationsPlot)
    {
        guard
            
            let device:MTLDevice = MTLCreateSystemDefaultDevice(),
            let library:MTLLibrary = device.newDefaultLibrary(),
            let vertexFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kPlotVertexFunction),
            let fragmentFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kPlotFragmentFunction),
            let kernelFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kPlotKernelFunction)
            
        else
        {
            return nil
        }
        
        do
        {
            try pipelineCompute = device.makeComputePipelineState(
                function:kernelFunction)
        }
        catch
        {
            return nil
        }
        
        self.kernelFunction = kernelFunction
        commandQueue = device.makeCommandQueue()
        
        let sampleDescriptor = MTLSamplerDescriptor()
        sampleDescriptor.minFilter = MetalConstants.kSamplerMinFilter
        sampleDescriptor.magFilter = MetalConstants.kSamplerMagFilter
        sampleDescriptor.mipFilter = MetalConstants.kSamplerMipFilter
        sampleDescriptor.sAddressMode = MetalConstants.kSamplerSAddressMode
        sampleDescriptor.tAddressMode = MetalConstants.kSamplerTAddressMode
        sampleDescriptor.rAddressMode = MetalConstants.kSamplerRAddressMode
        sampleDescriptor.lodMinClamp = MetalConstants.kSamplerLodMinClamp
        sampleDescriptor.lodMaxClamp = MetalConstants.kSamplerLodMaxClamp
        sampleDescriptor.maxAnisotropy = MetalConstants.kSamplerMaxAnisotropy
        sampleDescriptor.normalizedCoordinates = MetalConstants.kSamplerNormalizedCoordinates
        samplerState = device.makeSamplerState(descriptor:sampleDescriptor)
        
        let pipelineDescriptor:MTLRenderPipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        
        let colorAttachment:MTLRenderPipelineColorAttachmentDescriptor = pipelineDescriptor.colorAttachments[
            MetalConstants.kColorAttachmentIndex]
        colorAttachment.pixelFormat = MetalConstants.kPixelFormat
        colorAttachment.isBlendingEnabled = MetalConstants.kBlendingEnabled
        colorAttachment.rgbBlendOperation = MetalConstants.kRgbBlendOperation
        colorAttachment.alphaBlendOperation = MetalConstants.kAlphaBlendOperation
        colorAttachment.sourceRGBBlendFactor = MetalConstants.kSourceRgbBlendFactor
        colorAttachment.sourceAlphaBlendFactor = MetalConstants.kSourceAlphaBlendFactor
        colorAttachment.destinationRGBBlendFactor = MetalConstants.kDestinationRgbBlendFactor
        colorAttachment.destinationAlphaBlendFactor = MetalConstants.kDestinationAlphaBlendFactor
        
        do
        {
            try pipelineState = device.makeRenderPipelineState(descriptor:pipelineDescriptor)
        }
        catch
        {
            return nil
        }
        
        threadgroupCounts = MTLSizeMake(
            MetalConstants.kThreadgroupWidth,
            MetalConstants.kThreadgroupHeight,
            MetalConstants.kThreadgroupDeep)
        threadgroups = MTLSizeMake(
            0,
            0,
            MetalConstants.kThreadgroupDeep)
        
        positionBuffer = MetalPosition.position(
            device:device,
            positionX:0,
            positionY:0)
        
        super.init(frame:CGRect.zero, device:device)
        backgroundColor = UIColor.clear
        framebufferOnly = false
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.center
        autoResizeDrawable = true
        isPaused = false
        clearColor = MTLClearColor(red:1, green:1, blue:1, alpha:1)
        self.controller = controller
    }
    
    required init(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let scale:Int = Int(UIScreen.main.scale)
        let width:Int = Int(bounds.maxX) * scale
        let height:Int = Int(bounds.maxY) * scale
        let threadgroupsHorizontal:Int = width / MetalConstants.kThreadgroupWidth
        let threadgroupsVertical:Int = height / MetalConstants.kThreadgroupHeight
        threadgroupCounts = MTLSizeMake(
            MetalConstants.kThreadgroupWidth,
            MetalConstants.kThreadgroupHeight,
            MetalConstants.kThreadgroupDeep)
        threadgroups = MTLSizeMake(
            threadgroupsHorizontal,
            threadgroupsVertical,
            MetalConstants.kThreadgroupDeep)
        
        super.layoutSubviews()
    }
    
    override func draw()
    {
        super.draw()
        
        guard
            
            let drawable:CAMetalDrawable = currentDrawable,
            let passDescriptor:MTLRenderPassDescriptor = currentRenderPassDescriptor
            
        else
        {
            return
        }

        let baseTexture:MTLTexture = drawable.texture
        
        let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
        let renderEncoder:MTLRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(
            descriptor:passDescriptor)
        renderEncoder.setCullMode(MTLCullMode.none)
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(
            positionBuffer,
            offset:0,
            at:MetalConstants.kPositionIndex)
        renderEncoder.setFragmentSamplerState(
            samplerState,
            at:MetalConstants.kFragmentSamplerIndex)
        controller.model.modelRender?.render(
            renderEncoder:renderEncoder)
        renderEncoder.endEncoding()
        
        let commandEncoder:MTLComputeCommandEncoder = commandBuffer.makeComputeCommandEncoder()
        commandEncoder.setComputePipelineState(pipelineCompute)
        commandEncoder.setTexture(
            baseTexture,
            at:MetalConstants.kTextureReadIndex)
        commandEncoder.setTexture(
            baseTexture,
            at:MetalConstants.kTextureWriteIndex)
        commandEncoder.dispatchThreadgroups(
            threadgroups,
            threadsPerThreadgroup:threadgroupCounts)
        commandEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
    
    //MARK: public
    
    func newPosition(positionX:CGFloat, positionY:CGFloat)
    {
        guard
        
            let device:MTLDevice = self.device
        
        else
        {
            return
        }
        
        let floatX:Float = Float(positionX)
        let floatY:Float = Float(positionY)
        
        positionBuffer = MetalPosition.position(
            device:device,
            positionX:floatX,
            positionY:floatY)
    }
}
