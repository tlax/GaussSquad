import UIKit

class MCalculatorFunctionsItemTanDeg:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionTan")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemTanDeg_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let stateTanDeg:MKeyboardStateTanDeg = MKeyboardStateTanDeg(
            currentValue:currentValue)
        
        applyState(
            state:stateTanDeg,
            modelKeyboard:modelKeyboard,
            view:view)
    }
}
