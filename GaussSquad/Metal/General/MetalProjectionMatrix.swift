import UIKit

class MetalProjectionMatrix:MetalBufferableProtocol
{
    let minY:Float
    let maxY:Float
    let minX:Float
    let maxX:Float
    private let ratioX:Float
    private let ratioY:Float
    private let kHalf:Float = 2.0
    
    init()
    {
        let size:CGSize = UIScreen.main.bounds.size
        let floatWidth:Float = Float(size.width)
        let floatHeight:Float = Float(size.height)
        let floatWidth_2:Float = floatWidth / kHalf
        let floatHeight_2:Float = floatHeight / kHalf
        let minSize:Float = min(floatWidth, floatHeight)
        let deltaScale:Float = 1 / minSize
        let proportionX:Float = floatHeight / minSize
        let proportionY:Float = floatWidth / minSize
        minY = -floatHeight_2
        maxY = floatHeight_2
        minX = -floatWidth_2
        maxX = floatWidth_2
        ratioX = proportionX * deltaScale
        ratioY = proportionY * deltaScale
    }
    
    //MARK: bufferableProtocol
    
    func buffer() -> [Float]
    {
        let bufferArray:[Float] = [
            ratioX,
            ratioY
        ]
        
        return bufferArray
    }
}
