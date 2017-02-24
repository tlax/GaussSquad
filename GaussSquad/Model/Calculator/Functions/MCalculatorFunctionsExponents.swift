import Foundation

class MCalculatorFunctionsExponents:MCalculatorFunctions
{
    init()
    {
        let title:String = NSLocalizedString("MCalculatorFunctionsExponents_title", comment:"")
        
        let itemSin:MCalculatorFunctionsItemSin = MCalculatorFunctionsItemSin()
        let itemSinDeg:MCalculatorFunctionsItemSinDeg = MCalculatorFunctionsItemSinDeg()
        let itemCos:MCalculatorFunctionsItemCos = MCalculatorFunctionsItemCos()
        let itemCosDeg:MCalculatorFunctionsItemCosDeg = MCalculatorFunctionsItemCosDeg()
        let itemTan:MCalculatorFunctionsItemTan = MCalculatorFunctionsItemTan()
        let itemTanDeg:MCalculatorFunctionsItemTanDeg = MCalculatorFunctionsItemTanDeg()
        
        let items:[MCalculatorFunctionsItem] = [
            itemSin,
            itemSinDeg,
            itemCos,
            itemCosDeg,
            itemTan,
            itemTanDeg]
        
        super.init(
            title:title,
            items:items)
    }
}
