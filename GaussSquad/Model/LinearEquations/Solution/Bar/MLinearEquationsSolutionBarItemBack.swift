import UIKit

class MLinearEquationsSolutionBarItemBack:MLinearEquationsSolutionBarItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericBackRound"))
    }
    
    override func selected(controller:CLinearEquationsSolution)
    {
        controller.back()
    }
}
