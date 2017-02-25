import Foundation

class MCalculatorFunctionsExponents:MCalculatorFunctions
{
    init()
    {
        let title:String = NSLocalizedString("MCalculatorFunctionsExponents_title", comment:"")
        
        let itemSquareRoot:MCalculatorFunctionsItemSquareRoot = MCalculatorFunctionsItemSquareRoot()
        let itemCubeRoot:MCalculatorFunctionsItemCubeRoot = MCalculatorFunctionsItemCubeRoot()
        
        let items:[MCalculatorFunctionsItem] = [
            itemSquareRoot,
            itemCubeRoot]
        
        super.init(
            title:title,
            items:items)
    }
}
