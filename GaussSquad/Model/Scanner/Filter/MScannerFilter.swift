import Foundation
import MetalKit

class MScannerFilter
{
    weak var device:MTLDevice!
    weak var mtlLibrary:MTLLibrary!
    let commandQueue:MTLCommandQueue
    let textureLoader:MTKTextureLoader
    let originZero:MTLOrigin
    let sizeOfFloat:Int
    
    init(device:MTLDevice, mtlLibrary:MTLLibrary)
    {
        self.device = device
        self.mtlLibrary = mtlLibrary
        commandQueue = device.makeCommandQueue()
        textureLoader = MTKTextureLoader(device:device)
        originZero = MTLOriginMake(0, 0, 0)
        sizeOfFloat = MemoryLayout.size(ofValue:MetalConstants.kRepeatingElement)
    }
}
