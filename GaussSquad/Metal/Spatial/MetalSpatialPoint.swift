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
        let lineWidth_2:Float = lineWidth / 2.0
        
        let vector:float2 = vectorEnd - vectorStart;
        let vectorNormal:float2 = float2(-vector.y, vector.x)
        let vectorNormalized:float2 = normalize(vectorNormal)
        let vectorThickness:float2 = lineWidth_2 * vectorNormalized
        let vectorStartMin:float2 = vectorStart - vectorThickness
        let vectorStartMax:float2 = vectorStart + vectorThickness
        let vectorEndMin:float2 = vectorEnd - vectorThickness
        let vectorEndMax:float2 = vectorEnd + vectorThickness
        
        let startMin:MetalVertex = MetalVertex(
            positionX:vectorStartMin.x,
            positionY:vectorStartMin.y)
        let startMax:MetalVertex = MetalVertex(
            positionX:vectorStartMax.x,
            positionY:vectorStartMax.y)
        let endMin:MetalVertex = MetalVertex(
            positionX:vectorEndMin.x,
            positionY:vectorEndMin.y)
        let endMax:MetalVertex = MetalVertex(
            positionX:vectorEndMax.x,
            positionY:vectorEndMax.y)
        
        let vertexFace:MetalVertexFace = MetalVertexFace(
            topLeft:startMin,
            topRight:endMin,
            bottomLeft:startMax,
            bottomRight:endMax)
        
        vertexBuffer = device.generateBuffer(bufferable:vertexFace)
    }
}
