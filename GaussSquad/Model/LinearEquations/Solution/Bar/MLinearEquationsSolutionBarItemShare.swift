import UIKit

class MLinearEquationsSolutionBarItemShare:MLinearEquationsSolutionBarItem
{
    private let kActive:Bool = true
    
    init()
    {
        super.init(
            image:#imageLiteral(resourceName: "assetGenericSolutionShare"),
            active:kActive)
    }
    
    override func selected(controller:CLinearEquationsSolution)
    {
        controller.share()
    }
}
