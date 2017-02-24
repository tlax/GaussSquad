import Foundation

class MCalculatorFunctionsTrigonometry:MCalculatorFunctions
{
    init()
    {
        let title:String = NSLocalizedString("MCalculatorFunctionsTrigonometry_title", comment:"")
        
        let itemSin:MCalculatorFunctionsItemSin = MCalculatorFunctionsItemSin()
        let itemSinDeg:MCalculatorFunctionsItemSinDeg = MCalculatorFunctionsItemSinDeg()
        let itemCos:MCalculatorFunctionsItemCos = MCalculatorFunctionsItemCos()
        let itemTan:MCalculatorFunctionsItemTan = MCalculatorFunctionsItemTan()
        
        let items:[MCalculatorFunctionsItem] = [
            itemSin,
            itemSinDeg,
            itemCos,
            itemTan]
        
        super.init(
            title:title,
            items:items)
    }
}
