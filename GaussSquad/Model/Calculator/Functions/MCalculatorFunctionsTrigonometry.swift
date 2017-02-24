import Foundation

class MCalculatorFunctionsTrigonometry:MCalculatorFunctions
{
    init()
    {
        let title:String = NSLocalizedString("MCalculatorFunctionsTrigonometry_title", comment:"")
        
        let itemSin:MCalculatorFunctionsItemSin = MCalculatorFunctionsItemSin()
        let itemCos:MCalculatorFunctionsItemCos = MCalculatorFunctionsItemCos()
        
        let items:[MCalculatorFunctionsItem] = [
            itemSin,
            itemCos]
        
        super.init(
            title:title,
            items:items)
    }
}
