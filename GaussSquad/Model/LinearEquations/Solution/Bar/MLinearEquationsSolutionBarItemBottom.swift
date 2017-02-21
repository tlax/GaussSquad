import UIKit

class MLinearEquationsSolutionBarItemBottom:MLinearEquationsSolutionBarItem
{
    private let kActive:Bool = true
    
    init()
    {
        super.init(
            image:#imageLiteral(resourceName: "assetGenericSolutionBottom"),
            active:kActive)
    }
    
    override func selected(controller:CLinearEquationsSolution)
    {
        controller.bottom()
    }
}
