import UIKit

class CLinearEquationsPlot:CController
{
    private weak var viewPlot:VLinearEquationsPlot!
    private weak var stepDone:MLinearEquationsSolutionStepDone!
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        self.stepDone = stepDone
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewPlot:VLinearEquationsPlot = VLinearEquationsPlot(controller:self)
        self.viewPlot = viewPlot
        view = viewPlot
    }
}
