import UIKit

class MCalculatorFunctionsItemTan:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetGenericAdd")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemTan_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
}
