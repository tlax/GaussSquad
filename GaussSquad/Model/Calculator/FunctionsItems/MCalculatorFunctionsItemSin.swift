import UIKit

class MCalculatorFunctionsItemSin:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetGenericAdd")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemSin_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
}
