import Foundation

class MHomeItemLinearEquations:MHomeItem
{
    init()
    {
        let symbol:String = NSLocalizedString("MHomeItemLinearEquations_symbol", comment:"")
        let title:String = NSLocalizedString("MHomeItemLinearEquations_title", comment:"")
        
        super.init(
            symbol:symbol,
            title:title,
            image:#imageLiteral(resourceName: "assetGenericLinearEquations"))
    }
}
