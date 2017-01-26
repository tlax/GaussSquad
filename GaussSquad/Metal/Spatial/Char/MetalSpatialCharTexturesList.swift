import UIKit
import MetalKit

class MetalSpatialCharTexturesList
{
    private let textures:[MTLTexture]
    private let count:UInt32
    private var previousIndex:Int
    
    init(
        textureLoader:MTKTextureLoader,
        images:[UIImage])
    {
        var textures:[MTLTexture] = []
        
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
        count = UInt32(textures.count)
        previousIndex = -1
    }
    
    //MARK: public
    
    func random() -> MTLTexture
    {
        let randomIndex:Int = Int(arc4random_uniform(count))
        previousIndex = randomIndex
        let randomTexture:MTLTexture = textures[randomIndex]
        
        return randomTexture
    }
    
    func next() -> MTLTexture
    {
        previousIndex += 1
        
        if previousIndex >= Int(count)
        {
            previousIndex = 0
        }
        
        let nextTexture:MTLTexture = textures[previousIndex]
        
        return nextTexture
    }
}
