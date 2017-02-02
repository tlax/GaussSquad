import UIKit

class MLinearEquationsProjectBarItemNext:MLinearEquationsProjectBarItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericNext"))
    }
    
    override func selected(controller:CLinearEquationsProject)
    {
        controller.save()
    }
}
