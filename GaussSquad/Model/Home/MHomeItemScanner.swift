import Foundation

class MHomeItemScanner:MHomeItem
{
    init()
    {
        let symbol:String = NSLocalizedString("MHomeItemScanner_symbol", comment:"")
        let title:String = NSLocalizedString("MHomeItemScanner_title", comment:"")
        
        super.init(
            symbol:symbol,
            title:title,
            image:#imageLiteral(resourceName: "assetGenericLinearEquations"))
    }
    
    override func selected() -> CController?
    {
        let controller:CLinearEquations = CLinearEquations()
        
        return controller
    }
}
