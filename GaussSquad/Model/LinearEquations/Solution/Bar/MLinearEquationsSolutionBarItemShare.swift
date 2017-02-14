import UIKit

class MLinearEquationsSolutionBarItemShare:MLinearEquationsSolutionBarItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericSolutionShare"))
    }
    
    override func selected(controller:CLinearEquationsSolution)
    {
        controller.share()
    }
}
