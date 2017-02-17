import Foundation
import MetalKit

class MetalSpatialLine
{
    let vertexBuffer:MTLBuffer
    
    init(
        device:MTLDevice,
        aPointX:Float,
        aPointY:Float,
        bPointX:Float,
        bPointY:Float,
        lineWidth:Float)
    {
        let lineWidth_2:Float = lineWidth / 2.0
        let aPointXMin:Float = aPointX - lineWidth_2
        let aPointYMin:Float = aPointY - lineWidth_2
        let aPointXMax:Float = aPointX + lineWidth_2
        let aPointYMax:Float = aPointY + lineWidth_2
        let bPointXMin:Float = bPointX - lineWidth_2
        let bPointYMin:Float = bPointY - lineWidth_2
        let bPointXMax:Float = bPointX + lineWidth_2
        let bPointYMax:Float = bPointY + lineWidth_2
        
        let pointAMin:MetalVertex = MetalVertex(
            positionX:aPointXMin,
            positionY:aPointYMin)
        let pointAMax:MetalVertex = MetalVertex(
            positionX:aPointXMax,
            positionY:aPointYMax)
        let pointBMin:MetalVertex = MetalVertex(
            positionX:bPointXMin,
            positionY:bPointYMin)
        let pointBMax:MetalVertex = MetalVertex(
            positionX:bPointXMax,
            positionY:bPointYMax)
        
        let vertexFace:MetalVertexFace = MetalVertexFace(
            topLeft:pointAMin,
            topRight:pointAMax,
            bottomLeft:pointBMin,
            bottomRight:pointBMax)
        
        vertexBuffer = device.generateBuffer(bufferable:vertexFace)
    }
}
