import Foundation
import MetalKit

class MPlotRender:MetalRenderableProtocol
{
    let cartesian:MPlotRenderCartesian
    private let projection:MetalProjection
    
    init(device:MTLDevice)
    {
        projection = MetalProjection(device:device)
        cartesian = MPlotRenderCartesian(device:device)
    }
    
    //MARK: public
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection.projectionBuffer)
        cartesian.render(renderEncoder:renderEncoder)
    }
}
