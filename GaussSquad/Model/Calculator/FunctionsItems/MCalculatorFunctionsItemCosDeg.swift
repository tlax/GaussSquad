import UIKit

class MCalculatorFunctionsItemCosDeg:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionCos")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemCosDeg_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let currentString:String = modelKeyboard.lastString()
        let cosDegValue:Double = cos(currentValue * M_PI / 180.0)
        let cosDegString:String = modelKeyboard.numberAsString(scalar:cosDegValue)
        let descr:String = "deg cos(\(currentString)) = \(cosDegString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:cosDegString,
            descr:descr)
    }
}
