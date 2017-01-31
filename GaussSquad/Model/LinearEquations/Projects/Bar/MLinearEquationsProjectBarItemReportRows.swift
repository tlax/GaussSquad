import Foundation

class MLinearEquationsProjectBarItemReportRows:MLinearEquationsProjectBarItemReport
{
    init()
    {
        
        
        super.init(image:#imageLiteral(resourceName: "assetGenericRows"), title:"Rows", count:"2")
    }
    
    override func selected(controller:CLinearEquationsProject)
    {
        controller.save()
    }
}
