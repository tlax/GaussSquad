import Foundation

class MCalculatorFunctionsTrigonometry:MCalculatorFunctions
{
    init()
    {
        let title:String = NSLocalizedString("MCalculatorFunctionsTrigonometry_title", comment:"")
        
        let itemSin:MCalculatorFunctionsItemSin = MCalculatorFunctionsItemSin()
        
        let items:[MCalculatorFunctionsItem] = [
            itemSin]
        
        super.init(
            title:title,
            items:items)
    }
}
