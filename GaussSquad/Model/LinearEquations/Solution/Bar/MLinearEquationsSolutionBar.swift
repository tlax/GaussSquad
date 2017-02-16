import Foundation

class MLinearEquationsSolutionBar
{
    let items:[MLinearEquationsSolutionBarItem]
    
    init(stepDone:MLinearEquationsSolutionStepDone?)
    {
        let doneActive:Bool
        
        if stepDone != nil
        {
            doneActive = true
        }
        else
        {
            doneActive = false
        }
        
        let itemBack:MLinearEquationsSolutionBarItemBack = MLinearEquationsSolutionBarItemBack()
        let itemBottom:MLinearEquationsSolutionBarItemBottom = MLinearEquationsSolutionBarItemBottom()
        let itemPlot:MLinearEquationsSolutionBarItemPlot = MLinearEquationsSolutionBarItemPlot(
            active:doneActive)
        let itemShare:MLinearEquationsSolutionBarItemShare = MLinearEquationsSolutionBarItemShare()
        
        items = [
            itemBack,
            itemBottom,
            itemPlot,
            itemShare
        ]
    }
}
