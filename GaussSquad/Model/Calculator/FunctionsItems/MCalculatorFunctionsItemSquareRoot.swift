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
    
    override func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
        let currentValue:Double = modelKeyboard.lastNumber()
        let stateSquareRoot:MKeyboardStateSquareRoot = MKeyboardStateSquareRoot(
            currentValue:currentValue)
        
        applyState(
            state:stateSquareRoot,
            modelKeyboard:modelKeyboard,
            view:view)
    }
}
