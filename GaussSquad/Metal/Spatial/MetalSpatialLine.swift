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
        let aPointYMin:Float = aPointY - lineWidth_2
        let aPointYMax:Float = aPointY + lineWidth_2
        let bPointYMin:Float = bPointY - lineWidth_2
        let bPointYMax:Float = bPointY + lineWidth_2
        let aPointXMin:Float
        let aPointXMax:Float
        let bPointXMin:Float
        let bPointXMax:Float
        
        if aPointX < bPointX
        {
            aPointXMin = aPointX - lineWidth_2
            aPointXMax = aPointX - lineWidth_2
            bPointXMin = bPointX + lineWidth_2
            bPointXMax = bPointX + lineWidth_2
        }
        else if aPointX > bPointX
        {
            aPointXMin = aPointX + lineWidth_2
            aPointXMax = aPointX + lineWidth_2
            bPointXMin = bPointX - lineWidth_2
            bPointXMax = bPointX - lineWidth_2
        }
        else
        {
            aPointXMin = aPointX - lineWidth_2
            aPointXMax = aPointX + lineWidth_2
            bPointXMin = bPointX - lineWidth_2
            bPointXMax = bPointX + lineWidth_2
        }
        
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
            topRight:pointBMin,
            bottomLeft:pointAMax,
            bottomRight:pointBMax)
        
        vertexBuffer = device.generateBuffer(bufferable:vertexFace)
    }
}
