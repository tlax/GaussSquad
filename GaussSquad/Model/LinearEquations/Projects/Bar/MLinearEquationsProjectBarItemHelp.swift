import UIKit

class MLinearEquationsProjectBarItemHelp:MLinearEquationsProjectBarItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericHelp"))
    }
    
    override func selected(controller:CLinearEquationsProject)
    {
        controller.help()
    }
}
