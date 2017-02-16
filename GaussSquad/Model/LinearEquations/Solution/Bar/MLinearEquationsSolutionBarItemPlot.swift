import UIKit

class MLinearEquationsSolutionBarItemPlot:MLinearEquationsSolutionBarItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericNext"))
    }
    
    override func selected(controller:CLinearEquationsSolution)
    {
        controller.plot()
    }
}
