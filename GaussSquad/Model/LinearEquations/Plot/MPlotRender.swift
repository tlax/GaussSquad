import UIKit
import MetalKit

class MPlotRender:MetalRenderableProtocol
{
    private weak var device:MTLDevice?
    let cartesian:MPlotRenderCartesian
    private var projection:MTLBuffer
    
    init(device:MTLDevice)
    {
        self.device = device
        projection = MetalProjection.projectionMatrix(device:device)
        cartesian = MPlotRenderCartesian(device:device)
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
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection)
        cartesian.render(renderEncoder:renderEncoder)
    }
}
