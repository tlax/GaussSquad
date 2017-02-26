import UIKit

class MCalculatorFunctionsItemAnyExponent:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionAnyExponent")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemAnyExponent_title", comment:"")
        
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
        let cbrtValue:Double = cbrt(currentValue)
        let cbrtString:String = modelKeyboard.numberAsString(scalar:cbrtValue)
        let descr:String = "cube root(\(currentString)) = \(cbrtString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:cbrtString,
            descr:descr)
    }
}
