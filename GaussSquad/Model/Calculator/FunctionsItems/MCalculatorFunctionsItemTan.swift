import UIKit

class MCalculatorFunctionsItemTan:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionTan")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemTan_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let stateTan:MKeyboardStateTan = MKeyboardStateTan(
            currentValue:currentValue)
        
        applyState(
            state:stateTan,
            modelKeyboard:modelKeyboard,
            view:view)
    }
}
