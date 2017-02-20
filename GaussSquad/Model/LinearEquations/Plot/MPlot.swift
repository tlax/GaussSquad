import Foundation
import MetalKit

class MPlot
{
    private(set) var modelRender:MPlotRender?
    private weak var stepDone:MLinearEquationsSolutionStepDone!
    private let kDeltaPositionX:Double = 10
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        self.stepDone = stepDone
    }
    
    //MARK: public
    
    func makeRender(device:MTLDevice)
    {
        modelRender = MPlotRender(device:device)
        
        var positionX:Double = kDeltaPositionX
        
        for equation:MLinearEquationsSolutionEquation in stepDone.equations
        {
            guard
            
                let coefficient:MLinearEquationsSolutionEquationItemConstant = equation.result as? MLinearEquationsSolutionEquationItemConstant
            
            else
            {
                continue
            }
            
            let positionY:Double = coefficient.coefficient
            modelRender?.addIndeterminate(
                device:device,
                positionX:positionX,
                positionY:positionY)
            
            positionX += kDeltaPositionX
        }
    }
}
