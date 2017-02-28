import Foundation

class MCalculatorFunctionsExponents:MCalculatorFunctions
{
    init()
    {
        let title:String = NSLocalizedString("MCalculatorFunctionsExponents_title", comment:"")
        
        let itemSquareRoot:MCalculatorFunctionsItemSquareRoot = MCalculatorFunctionsItemSquareRoot()
        let itemCubeRoot:MCalculatorFunctionsItemCubeRoot = MCalculatorFunctionsItemCubeRoot()
        let itemAnyRoot:MCalculatorFunctionsItemAnyRoot = MCalculatorFunctionsItemAnyRoot()
        let itemSquare:MCalculatorFunctionsItemSquare = MCalculatorFunctionsItemSquare()
        let itemCube:MCalculatorFunctionsItemCube = MCalculatorFunctionsItemCube()
        let itemReciprocal:MCalculatorFunctionsItemReciprocal = MCalculatorFunctionsItemReciprocal()
        let itemAnyExponent:MCalculatorFunctionsItemAnyExponent = MCalculatorFunctionsItemAnyExponent()
        
        let items:[MCalculatorFunctionsItem] = [
            itemSquareRoot,
            itemCubeRoot,
            itemAnyRoot,
            itemSquare,
            itemCube,
            itemReciprocal,
            itemAnyExponent]
        
        super.init(
            title:title,
            items:items)
    }
}
