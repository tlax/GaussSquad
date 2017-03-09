import Foundation
import MetalKit
import MetalPerformanceShaders

class MScannerFilterItemDefine:MScannerFilterItem
{
    static func filterTexture(device:MTLDevice, library:MTLLibrary, texture:MTLTexture) -> MTLTexture?
    {
        let width:Int = texture.width
        let height:Int = texture.height
        let blankTexture:MTLTexture = MScannerFilter.blankTexure(
            device:device,
            width:width,
            height:height)
        let commandQueue:MTLCommandQueue = device.makeCommandQueue()
        let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
        
        let corners:Float = -1
        let center:Float = 5
        
        let weights:[Float] = [
            corners, 0, corners,
            0, center, 0,
            corners, 0, corners
        ]
        
        let convolution:MPSImageConvolution = MPSImageConvolution(
            device:device,
            kernelWidth:3,
            kernelHeight:3,
            weights:weights)
        convolution.edgeMode = MPSImageEdgeMode.zero
        convolution.encode(
            commandBuffer:commandBuffer,
            sourceTexture:texture,
            destinationTexture:blankTexture)
        
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
        
        return blankTexture
    }
}
