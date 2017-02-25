import UIKit

class MCalculatorFunctionsItemSin:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionSin")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemSin_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let currentString:String = modelKeyboard.lastString()
        let sinValue:Double = sin(currentValue)
        let sinString:String = modelKeyboard.numberAsString(scalar:sinValue)
        let descr:String = "rad sin(\(currentString)) = \(sinString)"
        
        applyUpdate(
            modelKeyboard:modelKeyboard,
            view:view,
            newEditing:sinString,
            descr:descr)
    }
}
