import UIKit
import MetalKit

class MetalSpatialSceneTextures
{
    let textures:[MTLTexture]
    
    init(
        device:MTLDevice,
        images:[UIImage])
    {
        var textures:[MTLTexture] = []
        
        let textureLoader:MTKTextureLoader = MTKTextureLoader(device:device)
        
        for image:UIImage in images
        {
            guard
                
                let texture:MTLTexture = textureLoader.loadImage(image:image)
                
            else
            {
                continue
            }
            
            textures.append(texture)
        }
        
        self.textures = textures
    }
}
