import UIKit

class MCalculatorFunctionsItemAnyRoot:MCalculatorFunctionsItem
{
    init()
    {
        let icon:UIImage = #imageLiteral(resourceName: "assetFunctionAnyRoot")
        let title:String = NSLocalizedString("MCalculatorFunctionsItemAnyRoot_title", comment:"")
        
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
        let stateRoot:MKeyboardStateRoot = MKeyboardStateRoot(
            previousValue:previousValue,
            editing:model.kInitial)
        model.states.append(stateRoot)
    }
}
