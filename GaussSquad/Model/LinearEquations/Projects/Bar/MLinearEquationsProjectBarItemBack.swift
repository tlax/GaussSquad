import UIKit

class MLinearEquationsProjectBarItemBack:MLinearEquationsProjectBarItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericBackRound"))
    }
    
    override func selected(controller:CLinearEquationsProject)
    {
        controller.save()
    }
}
