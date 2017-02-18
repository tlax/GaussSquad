import Foundation
import MetalKit

class MPlot
{
    private(set) var modelRender:MPlotRender?
    private weak var stepDone:MLinearEquationsSolutionStepDone!
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        self.stepDone = stepDone
    }
    
    //MARK: public
    
    func makeRender(device:MTLDevice)
    {
        modelRender = MPlotRender(device:device)
        
        for equation:MLinearEquationsSolutionEquation in stepDone.equations
        {
            guard
            
                let coefficient:MLinearEquationsSolutionEquationItemConstant = equation.result as? MLinearEquationsSolutionEquationItemConstant
            
            else
            {
                continue
            }
            
            let value:Double = coefficient.coefficient
            modelRender?.addIndeterminate(
                device:device,
                value:value)
        }
    }
}
