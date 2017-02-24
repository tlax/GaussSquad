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
        let stateCosDeg:MKeyboardStateCosDeg = MKeyboardStateCosDeg(
            currentValue:currentValue)
        
        applyState(
            state:stateCosDeg,
            modelKeyboard:modelKeyboard,
            view:view)
    }
}
