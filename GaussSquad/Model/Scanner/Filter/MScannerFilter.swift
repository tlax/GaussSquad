import Foundation
import MetalKit

class MScannerFilter
{
    private let items:[MScannerFilterItem.Type]
    
    init()
    {
        let itemHighContrast:MScannerFilterItemHighContrast.Type = MScannerFilterItemHighContrast.self
        
        items = [
            itemHighContrast]
    }
    
    //MARK: private
    
    func texturize(
        textureLoader:MTKTextureLoader,
        image:UIImage) -> MTLTexture?
    {
        let texture:MTLTexture?
        
        guard
            
            let cgImage:CGImage = image.cgImage
            
        else
        {
            return nil
        }
        
        do
        {
            texture = try textureLoader.newTexture(
                with:cgImage,
                options:[
                    MTKTextureLoaderOptionTextureUsage:
                        MTLTextureUsage.shaderRead.rawValue as NSObject,
                    MTKTextureLoaderOptionSRGB:
                        true as NSObject
                ])
        }
        catch
        {
            texture = nil
        }
        
        return texture
    }
    
    //MARK: public
    
    func filter(device:MTLDevice, image:UIImage) -> UIImage?
    {
        let textureLoader:MTKTextureLoader = MTKTextureLoader(
            device:device)
        
        guard
        
            let originalTexture:MTLTexture = texturize(
                textureLoader:textureLoader,
                image:image),
            let library:MTLLibrary = device.newDefaultLibrary()
        
        else
        {
            return nil
        }
        
        var exportTexture:MTLTexture = originalTexture
        
        for item:MScannerFilterItem.Type in items
        {
            exportTexture = item.filterTexture(
                device:device,
                library:library,
                texture:exportTexture)
        }
        
        let exportImage:UIImage? = exportTexture.exportImage()
        
        return exportImage
    }
}
