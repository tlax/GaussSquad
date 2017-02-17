import UIKit

class MetalProjectionMatrix:MetalBufferableProtocol
{
    private let ratioX:Float
    private let ratioY:Float
    
    init()
    {
        let size:CGSize = UIScreen.main.bounds.size
        let scale:Float = Float(UIScreen.main.scale)
        let width:Float = Float(size.width)
        let height:Float = Float(size.height)
        ratioX = width / scale
        ratioY = height / scale
    }
    
    init(width:CGFloat, height:CGFloat)
    {
        let scale:Float = Float(UIScreen.main.scale)
        ratioX = Float(width) / scale
        ratioY = Float(height) / scale
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
