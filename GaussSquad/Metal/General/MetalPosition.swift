import Foundation

class MetalPosition:MetalBufferableProtocol
{
    var positionX:Float
    var positionY:Float
    
    init(positionX:Float, positionY:Float)
    {
        self.positionX = positionX
        self.positionY = positionY
    }
    
    //MARK: bufferableProtocol
    
    func buffer() -> [Float]
    {
        let bufferArray:[Float] = [
            positionX,
            positionY
        ]
        
        return bufferArray
    }
}
