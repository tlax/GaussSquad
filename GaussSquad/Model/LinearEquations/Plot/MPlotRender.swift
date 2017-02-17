import Foundation
import MetalKit

class MPlotRender:MetalRenderableProtocol
{
    private let textureLoader:MTKTextureLoader
    private let projection:MetalProjection
    
    init(device:MTLDevice)
    {
        textureLoader = MTKTextureLoader(device:device)
        projection = MetalProjection(device:device)
        
        guard
            
            let textureMenuBase:MTLTexture = textureLoader.loadImage(
                image:#imageLiteral(resourceName: "assetTextureBase"))
            
        else
        {
            return
        }
    }
    
    //MARK: public
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection.projectionBuffer)
    }
}
