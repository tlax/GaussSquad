import Foundation
import MetalKit

class MetalSpatialLine
{
    let vertexBuffer:MTLBuffer
    
    init(vertexBuffer:MTLBuffer)
    {
        self.vertexBuffer = vertexBuffer
    }
    
    init(
        device:MTLDevice,
        aPointX:Float,
        aPointY:Float,
        bPointX:Float,
        bPointY:Float,
        lineWidth:Float)
    {
        let lineWidth_2:Float = lineWidth / 2.0
        let aPointXMin:Float
        let aPointYMin:Float
        let aPointXMax:Float
        let aPointYMax:Float
        let bPointXMin:Float
        let bPointYMin:Float
        let bPointXMax:Float
        let bPointYMax:Float
        
        
        
        let topLeft:MetalVertex = MetalVertex(
            positionX:left,
            positionY:top)
        let topRight:MetalVertex = MetalVertex(
            positionX:right,
            positionY:top)
        let bottomLeft:MetalVertex = MetalVertex(
            positionX:left,
            positionY:bottom)
        let bottomRight:MetalVertex = MetalVertex(
            positionX:right,
            positionY:bottom)
        
        let vertexFace:MetalVertexFace = MetalVertexFace(
            topLeft:topLeft,
            topRight:topRight,
            bottomLeft:bottomLeft,
            bottomRight:bottomRight)
        
        vertexBuffer = device.generateBuffer(bufferable:vertexFace)
    }
}
