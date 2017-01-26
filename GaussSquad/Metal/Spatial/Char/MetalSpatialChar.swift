import Foundation
import MetalKit

class MetalSpatialChar:MetalSpatialBaseTextured
{
    let textures:MetalSpatialCharTextures
    private let kWidth:Float = 180
    private let kHeight:Float = 180
    
    init(
        device:MTLDevice,
        textures:MetalSpatialCharTextures,
        direction:MetalSpatialBaseTexturedDirection)
    {
        self.textures = textures
        
        super.init(
            device:device,
            width:kWidth,
            height:kHeight,
            direction:direction)
    }
}
