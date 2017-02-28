import UIKit

class MCalculatorFunctionsItemSquareRoot:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionSquareRoot")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemSquareRoot_title", comment:"")
        
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
        let sqrtValue:Double = sqrt(currentValue)
        let sqrtString:String = modelKeyboard.numberAsString(scalar:sqrtValue)
        let descr:String = "square root(\(currentString)) = \(sqrtString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:sqrtString,
            descr:descr)
    }
}
