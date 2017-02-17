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
    
    func updateCameraImage(cIImage:CIImage)
    {
        let cameraRect:CGRect = cIImage.extent
        
        guard
            
            let cGImage:CGImage = cIContext.createCGImage(
                cIImage,
                from:cameraRect)
            
            else
        {
            return
        }
        
        camera.texture = textureLoader.loadCGImage(cGImage:cGImage)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection.projectionBuffer)
        
        camera.render(renderEncoder:renderEncoder)
        menu?.render(renderEncoder:renderEncoder)
    }
}
