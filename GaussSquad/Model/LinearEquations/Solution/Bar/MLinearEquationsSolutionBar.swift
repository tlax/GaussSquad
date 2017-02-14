import Foundation

class MLinearEquationsSolutionBar
{
    let items:[MLinearEquationsSolutionBarItem]
    
    init()
    {
        let itemBottom:MLinearEquationsSolutionBarItemBottom = MLinearEquationsSolutionBarItemBottom()
        let itemPlot:MLinearEquationsSolutionBarItemPlot = MLinearEquationsSolutionBarItemPlot()
        
        items = [
            itemBottom,
            itemPlot
        ]
    }
}
