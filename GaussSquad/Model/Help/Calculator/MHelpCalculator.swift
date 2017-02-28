import Foundation

class MHelpCalculator:MHelp
{
    init()
    {
        let itemPascal:MHelpCalculatorItemPascal = MHelpCalculatorItemPascal()
        
        let items:[MHelpItem] = [
            itemPascal
        ]
        
        super.init(items:items)
    }
}
