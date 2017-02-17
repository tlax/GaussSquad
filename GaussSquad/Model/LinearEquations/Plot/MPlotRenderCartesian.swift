import UIKit
import MetalKit

class MPlotRenderCartesian:MetalRenderableProtocol
{
    private let rotationBuffer:MTLBuffer
    private let axisX:MetalSpatialLine
    private let positionBuffer:MTLBuffer
    private let kCameraWidth:Float = 480
    private let kCameraHeight:Float = 640
    
    init(device:MTLDevice)
    {
        let screenSize:CGRect = UIScreen.main.bounds
        let screenWidth:Float = Float(screenSize.width)
        let screenHeight:Float = Float(screenSize.height)
        let deltaWidth:Float = kCameraWidth / screenWidth
        let deltaHeight:Float = kCameraHeight / screenHeight
        let minDelta:Float = min(deltaWidth, deltaHeight)
        let textureWidth:Float = kCameraWidth / minDelta
        let textureHeight:Float = kCameraHeight / minDelta
        
        let position:MetalPosition = MetalPosition.zero()
        let rotation:MetalRotation = MetalRotation.none()
        positionBuffer = device.generateBuffer(bufferable:position)
        rotationBuffer = device.generateBuffer(bufferable:rotation)
        
        axisX = MetalSpatialLine(
            device:device,
            aPointX:100,
            aPointY:100,
            bPointX:200,
            bPointY:200,
            lineWidth:10)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.render(
            vertex:axisX.vertexBuffer,
            position:positionBuffer,
            rotation:rotationBuffer)
    }
}
