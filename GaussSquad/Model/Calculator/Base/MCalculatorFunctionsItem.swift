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
    
    func applyUpdate(
        modelKeyboard:MKeyboard,
        view:UITextView,
        newEditing:String,
        descr:String)
    {
        guard
            
            let lastState:MKeyboardState = modelKeyboard.states.last
            
        else
        {
            return
        }
        
        let emptyString:String = modelKeyboard.kEmpty
        
        DispatchQueue.main.async
        { [weak view] in
            
            guard
                
                let view:UITextView = view
                
            else
            {
                return
            }
            
            view.text = emptyString
            view.insertText(newEditing)
            lastState.editing = newEditing
            
            NotificationCenter.default.post(
                name:Notification.functionUpdate,
                object:descr)
        }
    }
    
    func applyTo(modelKeyboard:MKeyboard, view:UITextView)
    {
    }
}
