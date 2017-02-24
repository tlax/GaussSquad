import UIKit

class MCalculatorFunctionsItem
{
    let icon:UIImage
    let title:String
    
    init(icon:UIImage, title:String)
    {
        self.icon = icon
        self.title = title
    }
    
    //MARK: public
    
    func selected(controller:CCalculator)
    {
        let textView:UITextView = controller.viewCalculator.viewText
        
        guard
        
            let keyboard:VKeyboard = textView.inputView as? VKeyboard
        
        else
        {
            return
        }
        
        applyTo(
            modelKeyboard:keyboard.model,
            view:textView)
    }
    
    func applyState(
        state:MKeyboardStateExtra,
        modelKeyboard:MKeyboard,
        view:UITextView)
    {
        modelKeyboard.states.append(state)
        
        DispatchQueue.main.async
        { [weak view] in
            
            guard
                
                let view:UITextView = view
                
            else
            {
                return
            }
            
            modelKeyboard.commitIfNeeded(view:view)
            
            let previousString:String = modelKeyboard.lastString()
            let statePlain:MKeyboardStatePlain = MKeyboardStatePlain(
                editing:previousString)
            modelKeyboard.states.append(statePlain)
        }
    }
    
    func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
    }
}
