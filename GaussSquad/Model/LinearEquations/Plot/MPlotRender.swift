import UIKit
import MetalKit

class MPlotRender:MetalRenderableProtocol
{
    private let cartesian:MPlotRenderCartesian
    private var projection:MTLBuffer
    private var indeterminates:[MPlotRenderIndeterminate]
    private weak var device:MTLDevice?
    private let kMinX:Float = 1
    private let kMaxX:Float = 100
    
    init(device:MTLDevice)
    {
        self.device = device
        projection = MetalProjection.projectionMatrix(device:device)
        cartesian = MPlotRenderCartesian(device:device)
        indeterminates = []
    }
    
    //MARK: public
    
    func updateProjection(width:CGFloat, height:CGFloat)
    {
        guard
        
            let device:MTLDevice = self.device
        
        else
        {
            return
        }
        
        projection = MetalProjection.projectionMatrix(
            device:device,
            width:width,
            height:height)
    }
    
    func addIndeterminate(
        device:MTLDevice,
        value:Double)
    {
        let floatValue:Float = Float(value)
        let minY:Float = floatValue * kMinX
        let maxY:Float = floatValue * kMaxX
        
        let indeterminate:MPlotRenderIndeterminate = MPlotRenderIndeterminate(
            device:device,
            aPointX:kMinX,
            aPointY:minY,
            bPointX:kMaxX,
            bPointY:maxY,
            color:UIColor.squadBlue)
        
        indeterminates.append(indeterminate)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection)
        cartesian.render(renderEncoder:renderEncoder)
        
        for indeterminate:MPlotRenderIndeterminate in indeterminates
        {
            indeterminate.render(
                renderEncoder:renderEncoder)
        }
    }
}
