import UIKit

class MCalculatorFunctionsItemReciprocal:MCalculatorFunctionsItem
{
    private let kExponent:Double = -1
    
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionSquareRoot")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemReciprocal_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func processFunction(
        currentValue:Double,
        currentString:String,
        modelKeyboard:MKeyboard,
        view:UITextView)
    {
        let inversedValue:Double = pow(currentValue, kExponent)
        let inversedString:String = modelKeyboard.numberAsString(scalar:inversedValue)
        let descr:String = "reciprocal (\(currentString)) = \(inversedString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:inversedString,
            descr:descr)
    }
}
