import Foundation

class MLinearEquationsProjectBarItemButtonBack:MLinearEquationsProjectBarItemButton
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericBack"))
    }
    
    override func selected(controller:CLinearEquationsProject)
    {
        controller.save()
    }
}
