import Foundation
import MetalKit

class MetalSpatialLine
{
    class func vertex(device:MTLDevice,
                      vectorStart:float2,
                      vectorEnd:float2,
                      lineWidth:Float) -> MTLBuffer
    {
        let line:MetalSpatialLine = MetalSpatialLine(
            device:device,
            vectorStart:vectorStart,
            vectorEnd:vectorEnd,
            lineWidth:lineWidth)
        
        let buffer:MTLBuffer = line.vertexBuffer
        
        return buffer
    }
    
    private let vertexBuffer:MTLBuffer
    private let kTop:Float = 0
    private let kBottom:Float = 1
    private let kLeft:Float = 0
    private let kRight:Float = 1
    
    private init(
        device:MTLDevice,
        vectorStart:float2,
        vectorEnd:float2,
        lineWidth:Float)
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
        
        let startMin:MetalVertexTextured = MetalVertexTextured(
            positionX:vectorStartMin.x,
            positionY:vectorStartMin.y,
            horizontal:kLeft,
            vertical:kTop)
        let startMax:MetalVertexTextured = MetalVertexTextured(
            positionX:vectorStartMax.x,
            positionY:vectorStartMax.y,
            horizontal:kLeft,
            vertical:kBottom)
        let endMin:MetalVertexTextured = MetalVertexTextured(
            positionX:vectorEndMin.x,
            positionY:vectorEndMin.y,
            horizontal:kRight,
            vertical:kTop)
        let endMax:MetalVertexTextured = MetalVertexTextured(
            positionX:vectorEndMax.x,
            positionY:vectorEndMax.y,
            horizontal:kRight,
            vertical:kBottom)
        
        let vertexFace:MetalVertexFace = MetalVertexFace(
            topLeft:startMin,
            topRight:endMin,
            bottomLeft:startMax,
            bottomRight:endMax)
        
        vertexBuffer = device.generateBuffer(bufferable:vertexFace)
    }
}
