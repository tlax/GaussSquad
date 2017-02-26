import UIKit

class MCalculatorFunctionsItemAnyExponent:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionAnyExponent")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemAnyExponent_title", comment:"")
        
        super.init(
            icon:icon,
            title:title)
    }
    
    override func selected(controller:CCalculator)
    {
        guard
            
            let textView:UITextView = controller.viewCalculator.viewText,
            let keyboard:VKeyboard = textView.inputView as? VKeyboard
            
        else
        {
            return
        }
        
        let model:MKeyboard = keyboard.model
        model.commitIfNeeded(view:textView)
        
        let previousValue:Double = model.lastNumber()
        let stateExponent:MKeyboardStateExponent = MKeyboardStateExponent(
            previousValue:previousValue,
            editing:model.kInitial)
        model.states.append(stateExponent)
    }
}
