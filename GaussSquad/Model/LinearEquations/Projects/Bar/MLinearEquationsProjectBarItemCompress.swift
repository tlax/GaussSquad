import UIKit

class MLinearEquationsProjectBarItemCompress:MLinearEquationsProjectBarItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericCompress"))
    }
    
    override func selected(controller:CLinearEquationsProject)
    {
        controller.compress()
    }
}
