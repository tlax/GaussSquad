import Foundation

class MLinearEquationsSolutionBar
{
    let items:[MLinearEquationsSolutionBarItem]
    
    init(stepDone:MLinearEquationsSolutionStepDone?)
    {
        var items:[MLinearEquationsSolutionBarItem] = []
        
        let itemBack:MLinearEquationsSolutionBarItemBack = MLinearEquationsSolutionBarItemBack()
        items.append(itemBack)
        
        let itemBottom:MLinearEquationsSolutionBarItemBottom = MLinearEquationsSolutionBarItemBottom()
        items.append(itemBottom)
        
        if stepDone != nil
        {
            let itemPlot:MLinearEquationsSolutionBarItemPlot = MLinearEquationsSolutionBarItemPlot()
            items.append(itemPlot)
        }
        
        let itemShare:MLinearEquationsSolutionBarItemShare = MLinearEquationsSolutionBarItemShare()
        items.append(itemShare)
        
        self.items = items
    }
}
