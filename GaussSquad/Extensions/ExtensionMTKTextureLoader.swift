import UIKit
import MetalKit

extension MTKTextureLoader
{
    func loadImage(image:UIImage) -> MTLTexture?
    {
        guard
            
            let cgImage:CGImage = image.cgImage
            
        else
        {
            return nil
        }
        
        let texture:MTLTexture
        
        do
        {
            texture = try newTexture(
                with:cgImage,
                options:[
                    MTKTextureLoaderOptionTextureUsage:
                        MetalConstants.kTextureUsage,
                    MTKTextureLoaderOptionSRGB:
                        MetalConstants.kTextureSrgb])
        }
        catch
        {
            return nil
        }
        
        return texture
    }
}
