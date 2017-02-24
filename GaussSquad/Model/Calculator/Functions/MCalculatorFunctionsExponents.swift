import Foundation

class MCalculatorFunctionsExponents:MCalculatorFunctions
{
    init()
    {
        let title:String = NSLocalizedString("MCalculatorFunctionsExponents_title", comment:"")
        
        let itemSquareRoot:MCalculatorFunctionsItemSquareRoot = MCalculatorFunctionsItemSquareRoot()
        
        let items:[MCalculatorFunctionsItem] = [
            itemSquareRoot]
        
        super.init(
            title:title,
            items:items)
    }
}
