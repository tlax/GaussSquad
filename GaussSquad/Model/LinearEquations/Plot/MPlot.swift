import Foundation

class MPlot
{
    var modelRender:MPlotRender?
    private weak var stepDone:MLinearEquationsSolutionStepDone!
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        self.stepDone = stepDone
    }
}
