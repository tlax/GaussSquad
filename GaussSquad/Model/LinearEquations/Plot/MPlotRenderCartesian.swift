import UIKit
import MetalKit

class MPlotRenderCartesian:MetalRenderableProtocol
{
    private let axisX:MTLBuffer
    private let axisY:MTLBuffer
    private let color:MTLBuffer
    private let kAxisWidth:Float = 1
    private let kBoundaries:Float = 2000
    
    init(device:MTLDevice)
    {
        let vectorStartX:float2 = float2(-kBoundaries, 0)
        let vectorEndX:float2 = float2(kBoundaries, 0)
        let vectorStartY:float2 = float2(0, -kBoundaries)
        let vectorEndY:float2 = float2(0, kBoundaries)
        
        axisX = MetalSpatialLine.vertex(
            device:device,
            vectorStart:vectorStartX,
            vectorEnd:vectorEndX,
            lineWidth:kAxisWidth)
        
        axisY = MetalSpatialLine.vertex(
            device:device,
            vectorStart:vectorStartY,
            vectorEnd:vectorEndY,
            lineWidth:kAxisWidth)
        
        color = MetalColor.color(
            device:device,
            originalColor:UIColor.black)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.render(
            vertex:axisX,
            color:color)
        
        renderEncoder.render(
            vertex:axisY,
            color:color)
    }
}
