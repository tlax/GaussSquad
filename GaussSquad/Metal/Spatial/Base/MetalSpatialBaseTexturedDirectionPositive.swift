import Foundation

class MetalSpatialBaseTexturedDirectionPositive:MetalSpatialBaseTexturedDirection
{
    private let kTop:Float = 0
    private let kBottom:Float = 1
    private let kLeft:Float = 0
    private let kRight:Float = 1
    
    init()
    {
        super.init(
            top:kTop,
            bottom:kBottom,
            left:kLeft,
            right:kRight)
    }
}
