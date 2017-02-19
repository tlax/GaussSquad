import UIKit
import MetalKit

class MPlotRender:MetalRenderableProtocol
{
    private let cartesian:MPlotRenderCartesian
    private var projection:MTLBuffer
    private var indeterminates:[MPlotRenderIndeterminate]
    private let colors:[UIColor]
    private weak var device:MTLDevice?
    private let kMinX:Float = 1
    private let kMaxX:Float = 100
    
    init(device:MTLDevice)
    {
        colors = [
            UIColor.squadBlue,
            UIColor.squadRed,
            UIColor.squadGreen,
            UIColor.purple,
            UIColor.brown,
            UIColor.orange,
            UIColor.yellow,
            UIColor.gray
        ]
        
        self.device = device
        projection = MetalProjection.projectionMatrix(device:device)
        cartesian = MPlotRenderCartesian(device:device)
        indeterminates = []
    }
    
    //MARK: public
    
    func updateProjection(width:CGFloat, height:CGFloat)
    {
        guard
        
            let device:MTLDevice = self.device
        
        else
        {
            return
        }
        
        projection = MetalProjection.projectionMatrix(
            device:device,
            width:width,
            height:height)
    }
    
    func addIndeterminate(
        device:MTLDevice,
        value:Double)
    {
        let floatValue:Float = Float(value)
        let minY:Float = floatValue * kMinX
        let maxY:Float = floatValue * kMaxX
        let vectorStart:float2 = float2(kMinX, minY)
        let vectorEnd:float2 = float2(kMaxX, maxY)
        let indexColor:Int = indeterminates.count % colors.count
        let color:UIColor = colors[indexColor]
        
        let indeterminate:MPlotRenderIndeterminate = MPlotRenderIndeterminate(
            device:device,
            vectorStart:vectorStart,
            vectorEnd:vectorEnd,
            color:color)
        
        indeterminates.append(indeterminate)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection)
        cartesian.render(renderEncoder:renderEncoder)
        
        for indeterminate:MPlotRenderIndeterminate in indeterminates
        {
            indeterminate.render(
                renderEncoder:renderEncoder)
        }
    }
}
