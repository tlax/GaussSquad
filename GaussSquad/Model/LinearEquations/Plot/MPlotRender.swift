import UIKit
import MetalKit

class MPlotRender:MetalRenderableProtocol
{
    private weak var device:MTLDevice?
    let cartesian:MPlotRenderCartesian
    private var projection:MetalProjection
    
    init(device:MTLDevice)
    {
        self.device = device
        projection = MetalProjection(device:device)
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
        
        projection = MetalProjection(
            device:device,
            width:width,
            height:height)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection.projectionBuffer)
        cartesian.render(renderEncoder:renderEncoder)
    }
}
