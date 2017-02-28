import Foundation

class MHelpCalculator:MHelp
{
    init()
    {
        let itemPascal:MHelpCalculatorItemPascal = MHelpCalculatorItemPascal()
        let itemOptions:MHelpCalculatorItemOptions = MHelpCalculatorItemOptions()
        let itemFunctions:MHelpCalculatorItemFunctions = MHelpCalculatorItemFunctions()
        let itemUndo:MHelpCalculatorItemUndo = MHelpCalculatorItemUndo()
        
        let items:[MHelpItem] = [
            itemPascal,
            itemOptions,
            itemFunctions,
            itemUndo
        ]
        
        super.init(items:items)
    }
}
