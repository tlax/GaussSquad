import Foundation

class MHomeItemCalculator:MHomeItem
{
    init()
    {
        let symbol:String = NSLocalizedString("MHomeItemCalculator_symbol", comment:"")
        let title:String = NSLocalizedString("MHomeItemCalculator_title", comment:"")
        
        super.init(
            symbol:symbol,
            title:title,
            image:#imageLiteral(resourceName: "assetGenericArithmetic"))
    }
}
