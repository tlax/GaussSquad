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
        guard
            
            let lastState:MKeyboardState = modelKeyboard.states.last
            
        else
        {
            return
        }
        
        modelKeyboard.states.append(state)
        
        DispatchQueue.main.async
        { [weak view] in
            
            guard
                
                let view:UITextView = view
                
            else
            {
                return
            }
            
            state.unflowedCommitState(
                model:modelKeyboard,
                view:view)
            
            NotificationCenter.default.post(
                name:Notification.keyboardUpdate,
                object:state)
            
            lastState.commitState(
                model:modelKeyboard,
                view:view)
            
            NotificationCenter.default.post(
                name:Notification.keyboardUpdate,
                object:lastState)
            
            state.editing = lastState.editing
        }
    }
    
    func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
    }
}
