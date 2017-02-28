import UIKit
import MetalKit

class MLinearEquationsPlotRenderIndeterminate:MetalRenderableProtocol
{
    private let texturePoint:MTLTexture
    private let textureLine:MTLTexture
    private let point:MTLBuffer
    private let line:MTLBuffer
    private let color:MTLBuffer
    private let kRadius:Float = 25
    private let kLineWidth:Float = 6
    
    init(device:MTLDevice,
         texturePoint:MTLTexture,
         textureLine:MTLTexture,
         positionX:Float,
         positionY:Float,
         color:UIColor)
    {
        self.texturePoint = texturePoint
        self.textureLine = textureLine
        
        let originPoint:float2 = float2(positionX, 0)
        let endPoint:float2 = float2(positionX, positionY)
        
        point = MetalSpatialPoint.vertex(
            device:device,
            positionX:positionX,
            positionY:positionY,
            radius:kRadius)
        
        line = MetalSpatialLine.vertex(
            device:device,
            vectorStart:originPoint,
            vectorEnd:endPoint,
            lineWidth:kLineWidth)
        
        self.color = MetalColor.color(
            device:device,
            originalColor:color)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.render(
            vertex:line,
            color:color,
            texture:textureLine)
        
        renderEncoder.render(
            vertex:point,
            color:color,
            texture:texturePoint)
    }
}
