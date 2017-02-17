import UIKit

class MetalProjection
{
    let projectionBuffer:MTLBuffer
    
    init(device:MTLDevice)
    {
        let projectionMatrix:MetalProjectionMatrix = MetalProjectionMatrix()
        
        projectionBuffer = device.generateBuffer(
            bufferable:projectionMatrix)
    }
    
    init(device:MTLDevice, width:CGFloat, height:CGFloat)
    {
        let projectionMatrix:MetalProjectionMatrix = MetalProjectionMatrix(
            width:width,
            height:height)
        
        projectionBuffer = device.generateBuffer(
            bufferable:projectionMatrix)
    }
}
