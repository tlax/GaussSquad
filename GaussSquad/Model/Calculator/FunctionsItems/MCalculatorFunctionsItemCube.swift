import UIKit

class MCalculatorFunctionsItemCube:MCalculatorFunctionsItem
{
    private let kExponent:Double = 3
    
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionSquareRoot")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemCube_title", comment:"")
        
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
        let cbValue:Double = pow(currentValue, kExponent)
        let cbString:String = modelKeyboard.numberAsString(scalar:cbValue)
        let descr:String = "cube (\(currentString)) = \(cbString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:cbString,
            descr:descr)
    }
}
