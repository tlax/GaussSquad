import UIKit
import MetalKit

class MPlotRenderIndeterminate:MetalRenderableProtocol
{
    private let vector:MTLBuffer
    private let color:MTLBuffer
    private let kLineWidth:Float = 20
    
    init(device:MTLDevice,
         vectorStart:float2,
         vectorEnd:float2,
         color:UIColor)
    {
        vector = MetalSpatialLine.vertex(
            device:device,
            vectorStart:vectorStart,
            vectorEnd:vectorEnd,
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
