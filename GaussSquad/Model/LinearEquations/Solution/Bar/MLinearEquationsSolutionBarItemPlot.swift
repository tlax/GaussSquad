import UIKit

class MLinearEquationsSolutionBarItemPlot:MLinearEquationsSolutionBarItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericSolutionBottom"))
    }
    
    override func selected(controller:CLinearEquationsSolution)
    {
        controller.bottom()
    }
}
