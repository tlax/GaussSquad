import Foundation
import MetalKit

class MetalSpatialBaseTexturedPositive:MetalSpatialBaseTextured
{
    init(
        device:MTLDevice,
        width:Float,
        height:Float)
    {
        let direction:MetalSpatialBaseTexturedDirectionPositive = MetalSpatialBaseTexturedDirectionPositive()
        
        super.init(
            device:device,
            width:width,
            height:height,
            direction:direction)
    }
}
