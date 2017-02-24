import UIKit

class MCalculatorFunctionsItemSinDeg:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionSin")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemSinDeg_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let stateSinDeg:MKeyboardStateSinDeg = MKeyboardStateSinDeg(
            currentValue:currentValue)
        
        applyState(
            state:stateSinDeg,
            modelKeyboard:modelKeyboard,
            view:view)
    }
}
