import Foundation
import MetalKit

class MPlot
{
    private(set) var modelRender:MPlotRender?
    private weak var stepDone:MLinearEquationsSolutionStepDone!
    private let kDeltaPosition:Double = 25
    private let deltaPosition_2:Double
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        deltaPosition_2 = kDeltaPosition + kDeltaPosition
        self.stepDone = stepDone
    }
    
    //MARK: public
    
    func makeRender(device:MTLDevice)
    {
        modelRender = MPlotRender(device:device)
        
        var positionX:Double = kDeltaPosition
        
        for equation:MLinearEquationsSolutionEquation in stepDone.equations
        {
            guard
            
                let coefficient:MLinearEquationsSolutionEquationItemConstant = equation.result as? MLinearEquationsSolutionEquationItemConstant
            
            else
            {
                continue
            }
            
            let positionY:Double = coefficient.coefficient * kDeltaPosition
            modelRender?.addIndeterminate(
                device:device,
                positionX:positionX,
                positionY:positionY)
            
            positionX += deltaPosition_2
        }
    }
}
