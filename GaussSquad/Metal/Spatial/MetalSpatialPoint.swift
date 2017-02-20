import Foundation
import MetalKit

class MetalSpatialPoint
{
    class func vertex(device:MTLDevice,
                      positionX:Float,
                      positionY:Float,
                      radius:Float) -> MTLBuffer
    {
        let point:MetalSpatialPoint = MetalSpatialPoint(
            device:device,
            positionX:positionX,
            positionY:positionY,
            radius:radius)
        
        let buffer:MTLBuffer = point.vertexBuffer
        
        return buffer
    }
    
    private let vertexBuffer:MTLBuffer
    
    private init(
        device:MTLDevice,
        positionX:Float,
        positionY:Float,
        radius:Float)
    {
        let minX:Float = positionX - radius
        let maxX:Float = positionX + radius
        let minY:Float = positionY - radius
        let maxY:Float = positionY + radius
        
        let topLeft:MetalVertex = MetalVertex(
            positionX:minX,
            positionY:minY)
        let topRight:MetalVertex = MetalVertex(
            positionX:maxX,
            positionY:minY)
        let bottomLeft:MetalVertex = MetalVertex(
            positionX:minX,
            positionY:maxY)
        let bottomRight:MetalVertex = MetalVertex(
            positionX:maxX,
            positionY:maxY)
        
        let vertexFace:MetalVertexFace = MetalVertexFace(
            topLeft:topLeft,
            topRight:topRight,
            bottomLeft:bottomLeft,
            bottomRight:bottomRight)
        
        vertexBuffer = device.generateBuffer(bufferable:vertexFace)
    }
}
