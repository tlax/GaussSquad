import Foundation
import MetalKit

class MPlot
{
    private(set) var zoom:Double = 1
    private(set) var modelRender:MPlotRender?
    private weak var stepDone:MLinearEquationsSolutionStepDone?
    private weak var device:MTLDevice?
    private let kDeltaPosition:Double = 10
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        self.stepDone = stepDone
    }
    
    //MARK: private
    
    private func makeIndeterminates()
    {
        guard
            
            let device:MTLDevice = self.device,
            let stepDone:MLinearEquationsSolutionStepDone = self.stepDone,
            let modelRender:MPlotRender = self.modelRender
        
        else
        {
            return
        }
        
        modelRender.clearIndeterminates()
        let positionZoom:Double = kDeltaPosition * zoom
        let positionZoom2:Double = positionZoom + positionZoom
        var positionX:Double = positionZoom
        
        for equation:MLinearEquationsSolutionEquation in stepDone.equations
        {
            guard
                
                let coefficient:MLinearEquationsSolutionEquationItemConstant = equation.result as? MLinearEquationsSolutionEquationItemConstant
                
            else
            {
                continue
            }
            
            let positionY:Double = coefficient.coefficient * positionZoom
            modelRender.addIndeterminate(
                device:device,
                positionX:positionX,
                positionY:positionY)
            
            positionX += positionZoom2
        }
    }
    
    //MARK: public
    
    func makeRender(device:MTLDevice)
    {
        self.device = device
        modelRender = MPlotRender(device:device)
        makeIndeterminates()
    }
    
    func updateZoom(zoom:Double)
    {
        self.zoom = zoom
        makeIndeterminates()
    }
}
