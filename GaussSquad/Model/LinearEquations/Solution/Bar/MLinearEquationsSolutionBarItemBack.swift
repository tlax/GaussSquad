import UIKit

class MLinearEquationsSolutionBarItemBack:MLinearEquationsSolutionBarItem
{
    private let kActive:Bool = true
    
    init()
    {
        super.init(
            image:#imageLiteral(resourceName: "assetGenericBackRound"),
            active:kActive)
    }
    
    override func selected(controller:CLinearEquationsSolution)
    {
        controller.back()
    }
}
