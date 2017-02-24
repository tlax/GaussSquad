import UIKit

class MCalculatorFunctionsItemCos:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionCos")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemCos_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
}
