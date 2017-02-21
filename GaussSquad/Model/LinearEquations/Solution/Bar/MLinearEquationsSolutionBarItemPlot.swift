import UIKit

class MLinearEquationsSolutionBarItemPlot:MLinearEquationsSolutionBarItem
{
    init(active:Bool)
    {
        super.init(
            image:#imageLiteral(resourceName: "assetGenericPlot"),
            active:active)
    }
    
    override func selected(controller:CLinearEquationsSolution)
    {
        controller.plot()
    }
}
