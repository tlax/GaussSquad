import UIKit
import MetalKit

class VLinearEquationsPlotMetal:MTKView
{
    private weak var controller:CLinearEquationsPlot!
    private let commandQueue:MTLCommandQueue
    private let pipelineState:MTLRenderPipelineState
    
    init?(controller:CLinearEquationsPlot)
    {
        guard
            
            let device:MTLDevice = MTLCreateSystemDefaultDevice(),
            let library:MTLLibrary = device.newDefaultLibrary(),
            let vertexFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kVertexFunction),
            let fragmentFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kFragmentFunction)
            
        else
        {
            return nil
        }
        
        commandQueue = device.makeCommandQueue()
        
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
        
        let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
        let renderEncoder:MTLRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(
            descriptor:passDescriptor)
        renderEncoder.setCullMode(MTLCullMode.none)
        renderEncoder.setRenderPipelineState(pipelineState)
        controller.model.modelRender?.render(
            renderEncoder:renderEncoder)

        renderEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
