import Foundation

class MLinearEquationsProjectBarItemButtonBack:MLinearEquationsProjectBarItemButton
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
