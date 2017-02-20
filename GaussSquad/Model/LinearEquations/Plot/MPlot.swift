import Foundation
import MetalKit

class MPlot
{
    var zoom:Double = 1
    private(set) var modelRender:MPlotRender?
    private weak var stepDone:MLinearEquationsSolutionStepDone!
    private let kDeltaPosition:Double = 1
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        self.stepDone = stepDone
    }
    
    //MARK: public
    
    func makeRender(device:MTLDevice)
    {
        modelRender = MPlotRender(device:device)
        
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
            modelRender?.addIndeterminate(
                device:device,
                positionX:positionX,
                positionY:positionY)
            
            positionX += positionZoom2
        }
    }
}
