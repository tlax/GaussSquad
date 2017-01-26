import Foundation

class MetalVertex:MetalBufferableProtocol
{
    private let positionX:Float
    private let positionY:Float
    private let kPositionZ:Float = 0
    
    init(
        positionX:Float,
        positionY:Float)
    {
        self.positionX = positionX
        self.positionY = positionY
    }
    
    //MARK: bufferableProtocol
    
    func buffer() -> [Float]
    {
        let bufferArray:[Float] = [
            positionX,
            positionY,
            kPositionZ
        ]
        
        return bufferArray
    }
}
