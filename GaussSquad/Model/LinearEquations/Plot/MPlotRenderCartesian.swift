import UIKit
import MetalKit

class MPlotRenderCartesian:MetalRenderableProtocol
{
    private let axisX:MetalSpatialLine
    private let axisY:MetalSpatialLine
    private let color:MTLBuffer
    private let kAxisWidth:Float = 5
    private let kBoundaries:Float = 2000
    
    init(device:MTLDevice)
    {
        axisX = MetalSpatialLine(
            device:device,
            aPointX:-kBoundaries,
            aPointY:0,
            bPointX:kBoundaries,
            bPointY:0,
            lineWidth:kAxisWidth)
        
        axisY = MetalSpatialLine(
            device:device,
            aPointX:0,
            aPointY:-kBoundaries,
            bPointX:0,
            bPointY:kBoundaries,
            lineWidth:kAxisWidth)
        
        color = MetalColor.color(
            device:device,
            originalColor:UIColor.black)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.render(
            vertex:axisX.vertexBuffer,
            color:color)
        
        renderEncoder.render(
            vertex:axisY.vertexBuffer,
            color:color)
    }
}
