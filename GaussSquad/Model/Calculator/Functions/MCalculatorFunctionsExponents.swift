import Foundation

class MCalculatorFunctionsExponents:MCalculatorFunctions
{
    init()
    {
        let title:String = NSLocalizedString("MCalculatorFunctionsExponents_title", comment:"")
        
        let itemSquareRoot:MCalculatorFunctionsItemSquareRoot = MCalculatorFunctionsItemSquareRoot()
        let itemCubeRoot:MCalculatorFunctionsItemCubeRoot = MCalculatorFunctionsItemCubeRoot()
        let itemSquare:MCalculatorFunctionsItemSquare = MCalculatorFunctionsItemSquare()
        let itemCube:MCalculatorFunctionsItemCube = MCalculatorFunctionsItemCube()
        let itemReciprocal:MCalculatorFunctionsItemReciprocal = MCalculatorFunctionsItemReciprocal()
        
        let items:[MCalculatorFunctionsItem] = [
            itemSquareRoot,
            itemCubeRoot,
            itemSquare,
            itemCube,
            itemReciprocal]
        
        super.init(
            title:title,
            items:items)
    }
}
