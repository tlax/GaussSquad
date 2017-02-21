import Foundation
import MetalKit

class MetalPosition:MetalBufferableProtocol
{
    class func position(
        device:MTLDevice,
        positionX:Float,
        positionY:Float) -> MTLBuffer
    {
        let metalPosition:MetalPosition = MetalPosition(
            positionX:positionX,
            positionY:positionY)
        
        let bufferPosition:MTLBuffer = device.generateBuffer(
            bufferable:metalPosition)
        
        return bufferPosition
    }
    
    private let positionX:Float
    private let positionY:Float
    
    private init(positionX:Float, positionY:Float)
    {
        self.positionX = positionX
        self.positionY = positionY
    }
    
    //MARK: bufferableProtocol
    
    func buffer() -> [Float]
    {
        let bufferArray:[Float] = [
            positionX,
            positionY
        ]
        
        return bufferArray
    }
}
