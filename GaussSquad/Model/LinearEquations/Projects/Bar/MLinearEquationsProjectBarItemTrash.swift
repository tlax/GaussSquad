import UIKit

class MLinearEquationsProjectBarItemTrash:MLinearEquationsProjectBarItem
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericTrash"))
    }
    
    override func selected(controller:CLinearEquationsProject)
    {
        controller.delete()
    }
}
