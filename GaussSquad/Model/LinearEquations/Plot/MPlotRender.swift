import UIKit
import MetalKit

class MPlotRender:MetalRenderableProtocol
{
    private weak var device:MTLDevice?
    private var projection:MTLBuffer
    private var indeterminates:[MPlotRenderIndeterminate]
    private let texturePoint:MTLTexture?
    private let textureLine:MTLTexture?
    private let cartesian:MPlotRenderCartesian?
    private let colors:[UIColor]
    
    init(device:MTLDevice)
    {
        let textureLoader:MTKTextureLoader = MTKTextureLoader(device:device)
        texturePoint = textureLoader.loadImage(
            image:#imageLiteral(resourceName: "assetTexturePoint"))
        
        colors = [
            UIColor.squadBlue,
            UIColor.squadRed,
            UIColor.squadGreen,
            UIColor.purple,
            UIColor.brown,
            UIColor.orange,
            UIColor.yellow
        ]
        
        if let textureLine:MTLTexture = textureLoader.loadImage(
            image:#imageLiteral(resourceName: "assetTextureLine"))
        {
            self.textureLine = textureLine
            cartesian = MPlotRenderCartesian(
                device:device,
                texture:textureLine)
        }
        else
        {
            self.textureLine = nil
            cartesian = nil
        }
        
        projection = MetalProjection.projectionMatrix(device:device)
        indeterminates = []
        self.device = device
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
        positionX:Double,
        positionY:Double)
    {
        guard
            
            let texturePoint:MTLTexture = self.texturePoint,
            let textureLine:MTLTexture = self.textureLine
        
        else
        {
            return
        }
        
        let floatPositionX:Float = Float(positionX)
        let floatPositionY:Float = Float(positionY)
        let indexColor:Int = indeterminates.count % colors.count
        let color:UIColor = colors[indexColor]
        
        let indeterminate:MPlotRenderIndeterminate = MPlotRenderIndeterminate(
            device:device,
            texturePoint:texturePoint,
            textureLine:textureLine,
            positionX:floatPositionX,
            positionY:floatPositionY,
            color:color)
        
        indeterminates.insert(indeterminate, at:0)
    }
    
    func clearIndeterminates()
    {
        indeterminates = []
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.projectionMatrix(
            projection:projection)
        cartesian?.render(renderEncoder:renderEncoder)
        
        for indeterminate:MPlotRenderIndeterminate in indeterminates
        {
            indeterminate.render(
                renderEncoder:renderEncoder)
        }
    }
}
