import UIKit
import MetalKit

class MetalProjection:MetalBufferableProtocol
{
    class func projectionMatrix(device:MTLDevice) -> MTLBuffer
    {
        let size:CGSize = UIScreen.main.bounds.size
        let width:CGFloat = size.width
        let height:CGFloat = size.height
        let projection:MetalProjection = MetalProjection(
            width:width,
            height:height)
        let metalBuffer:MTLBuffer = device.generateBuffer(
            bufferable:projection)
        
        return metalBuffer
    }
    
    class func projectionMatrix(
        device:MTLDevice,
        width:CGFloat,
        height:CGFloat) -> MTLBuffer
    {
        let projection:MetalProjection = MetalProjection(
            width:width,
            height:height)
        let metalBuffer:MTLBuffer = device.generateBuffer(
            bufferable:projection)
        
        return metalBuffer
    }
    
    private let ratioX:Float
    private let ratioY:Float
    
    private init(width:CGFloat, height:CGFloat)
    {
        let scale:Float = Float(UIScreen.main.scale)
        ratioX = Float(width) / scale
        ratioY = Float(height) / scale
    }
    
    //MARK: bufferableProtocol
    
    func buffer() -> [Float]
    {
        let bufferArray:[Float] = [
            ratioX,
            ratioY
        ]
        
        return bufferArray
    }
}
