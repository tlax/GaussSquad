import Foundation

class MCalculatorFunctionsTrigonometry:MCalculatorFunctions
{
    init()
    {
        let title:String = NSLocalizedString("MCalculatorFunctionsTrigonometry_title", comment:"")
        
        let itemSin:MCalculatorFunctionsItemSin = MCalculatorFunctionsItemSin()
        let itemSinDeg:MCalculatorFunctionsItemSinDeg = MCalculatorFunctionsItemSinDeg()
        let itemCos:MCalculatorFunctionsItemCos = MCalculatorFunctionsItemCos()
        let itemCosDeg:MCalculatorFunctionsItemCosDeg = MCalculatorFunctionsItemCosDeg()
        let itemTan:MCalculatorFunctionsItemTan = MCalculatorFunctionsItemTan()
        let itemTanDeg:MCalculatorFunctionsItemTanDeg = MCalculatorFunctionsItemTanDeg()
        
        let items:[MCalculatorFunctionsItem] = [
            itemSin,
            itemCos,
            itemTan,
            itemSinDeg,
            itemCosDeg,
            itemTanDeg]
        
        super.init(
            title:title,
            items:items)
    }
}
