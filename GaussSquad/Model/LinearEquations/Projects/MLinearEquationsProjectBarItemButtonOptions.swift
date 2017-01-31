import Foundation

class MLinearEquationsProjectBarItemButtonOptions:MLinearEquationsProjectBarItemButton
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetGenericOptions"))
    }
    
    override func selected(controller:CLinearEquationsProject)
    {
        controller.save()
    }
}
