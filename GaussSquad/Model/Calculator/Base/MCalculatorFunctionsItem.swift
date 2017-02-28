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
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self, weak controller] in
            
            guard
                
                let textView:UITextView = controller?.viewCalculator.viewText,
                let keyboard:VKeyboard = textView.inputView as? VKeyboard
                
            else
            {
                return
            }
            
            let model:MKeyboard = keyboard.model
            
            guard
                
                let lastState:MKeyboardState = model.states.last
                
            else
            {
                return
            }
            
            if lastState.needsUpdate
            {
                model.states.removeLast()
            }
            
            let currentValue:Double = model.lastNumber()
            let currentString:String = model.lastString()
            
            self?.processFunction(
                currentValue:currentValue,
                currentString:currentString,
                modelKeyboard:model,
                view:textView)
        }
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
    
    func processFunction(
        currentValue:Double,
        currentString:String,
        modelKeyboard:MKeyboard,
        view:UITextView)
    {
    }
}
