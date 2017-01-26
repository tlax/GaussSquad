import UIKit
import MetalKit

class MetalSpatialCharTextures
{
    let standTextures:MetalSpatialCharTexturesList
    let advanceTextures:MetalSpatialCharTexturesList
    
    init(
        device:MTLDevice,
        standImages:[UIImage],
        advanceImages:[UIImage])
    {
        let textureLoader:MTKTextureLoader = MTKTextureLoader(device:device)
        
        standTextures = MetalSpatialCharTexturesList(
            textureLoader:textureLoader,
            images:standImages)
        advanceTextures = MetalSpatialCharTexturesList(
            textureLoader:textureLoader,
            images:advanceImages)
        
    }
}
