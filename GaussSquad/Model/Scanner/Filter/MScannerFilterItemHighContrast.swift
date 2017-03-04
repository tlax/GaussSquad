import Foundation
import MetalKit

class MScannerFilterItemHighContrast:MScannerFilterItem
{
    static func filterTexture(device:MTLDevice, library:MTLLibrary, texture:MTLTexture) -> MTLTexture?
    {
        guard
            
            let mtlFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kFilterHighContrastKernelFunction)
            
        else
        {
            return nil
        }
        
        let pipelineState:MTLComputePipelineState
        
        do
        {
            try pipelineState = device.makeComputePipelineState(function:mtlFunction)
        }
        catch
        {
            return nil
        }
        
        let width:Int = texture.width
        let height:Int = texture.height
        let blankTexture:MTLTexture = MScannerFilter.blankTexure(
            device:device,
            width:width,
            height:height)
        let commandQueue:MTLCommandQueue = device.makeCommandQueue()
        let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder:MTLComputeCommandEncoder = commandBuffer.makeComputeCommandEncoder()
        let threadgroupsHorizontal:Int = width / MetalConstants.kThreadgroupWidth
        let threadgroupsVertical:Int = height / MetalConstants.kThreadgroupHeight
        let threadgroupCounts:MTLSize = MTLSizeMake(
            MetalConstants.kThreadgroupWidth,
            MetalConstants.kThreadgroupHeight,
            MetalConstants.kThreadgroupDeep)
        let threadgroups:MTLSize = MTLSizeMake(
            threadgroupsHorizontal,
            threadgroupsVertical,
            MetalConstants.kThreadgroupDeep)
        
        commandEncoder.setComputePipelineState(pipelineState)
        commandEncoder.setTexture(texture, at:0)
        commandEncoder.setTexture(blankTexture, at:1)
        commandEncoder.dispatchThreadgroups(
            threadgroups,
            threadsPerThreadgroup:threadgroupCounts)
        commandEncoder.endEncoding()
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()

        return blankTexture
    }
}
