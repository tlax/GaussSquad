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
        let stateSin:MKeyboardStateSin = MKeyboardStateSin(
            currentValue:currentValue)
        
        applyState(
            state:stateSin,
            modelKeyboard:modelKeyboard,
            view:view)
    }
}
