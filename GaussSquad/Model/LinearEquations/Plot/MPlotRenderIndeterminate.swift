import UIKit
import MetalKit

class MPlotRenderIndeterminate:MetalRenderableProtocol
{
    private let vector:MTLBuffer
    private let color:MTLBuffer
    private let kLineWidth:Float = 10
    
    init(device:MTLDevice,
        aPointX:Float,
        aPointY:Float,
        bPointX:Float,
        bPointY:Float,
        color:UIColor)
    {
        vector = MetalSpatialLine.vertex(
            device:device,
            aPointX:aPointX,
            aPointY:aPointY,
            bPointX:bPointX,
            bPointY:bPointY,
            lineWidth:kLineWidth)
        
        self.color = MetalColor.color(
            device:device,
            originalColor:color)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.render(
            vertex:vector,
            color:color)
    }
}
