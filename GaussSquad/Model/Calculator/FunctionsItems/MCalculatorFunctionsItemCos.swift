import UIKit

class MCalculatorFunctionsItemCos:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionCos")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemCos_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let stateCos:MKeyboardStateCos = MKeyboardStateCos(
            currentValue:currentValue)
        
        applyState(
            state:stateCos,
            modelKeyboard:modelKeyboard,
            view:view)
    }
}
