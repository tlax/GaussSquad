import UIKit
import MetalKit

class MPlotRenderIndeterminate:MetalRenderableProtocol
{
    private let texture:MTLTexture
    private let point:MTLBuffer
    private let color:MTLBuffer
    private let kRadius:Float = 25
    
    init(device:MTLDevice,
         texture:MTLTexture,
         positionX:Float,
         positionY:Float,
         color:UIColor)
    {
        self.texture = texture
        
        point = MetalSpatialPoint.vertex(
            device:device,
            positionX:positionX,
            positionY:positionY,
            radius:kRadius)
        
        self.color = MetalColor.color(
            device:device,
            originalColor:color)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.render(
            vertex:point,
            color:color,
            texture:texture)
    }
}
