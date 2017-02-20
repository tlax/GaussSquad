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
    private let kTop:Float = 0
    private let kBottom:Float = 1
    private let kLeft:Float = 0
    private let kRight:Float = 1
    
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
        
        let topLeft:MetalVertexTextured = MetalVertexTextured(
            positionX:minX,
            positionY:minY,
            horizontal:kLeft,
            vertical:kTop)
        let topRight:MetalVertexTextured = MetalVertexTextured(
            positionX:maxX,
            positionY:minY,
            horizontal:kRight,
            vertical:kTop)
        let bottomLeft:MetalVertexTextured = MetalVertexTextured(
            positionX:minX,
            positionY:maxY,
            horizontal:kLeft,
            vertical:kBottom)
        let bottomRight:MetalVertexTextured = MetalVertexTextured(
            positionX:maxX,
            positionY:maxY,
            horizontal:kRight,
            vertical:kBottom)
        
        let vertexFace:MetalVertexFace = MetalVertexFace(
            topLeft:topLeft,
            topRight:topRight,
            bottomLeft:bottomLeft,
            bottomRight:bottomRight)
        
        vertexBuffer = device.generateBuffer(bufferable:vertexFace)
    }
}
