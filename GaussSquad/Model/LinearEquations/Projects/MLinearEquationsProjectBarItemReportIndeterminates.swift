import Foundation

class MLinearEquationsProjectBarItemReportIndeterminates:MLinearEquationsProjectBarItemReport
{
    init()
    {
        
        
        super.init(image:#imageLiteral(resourceName: "assetGenericIndeterminates"), title:"Rows", count:"6")
    }
    
    override func selected(controller:CLinearEquationsProject)
    {
        controller.save()
    }
}
