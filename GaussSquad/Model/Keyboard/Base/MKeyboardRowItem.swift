import UIKit

class MKeyboardRowItem
{
    let icon:UIImage
    
    init(icon:UIImage)
    {
        self.icon = icon
    }
    
    //MARK: public
    
    func selected(
        model:MKeyboard,
        view:UITextView)
    {
        
    }
    
    func updateIfNeeded(model:MKeyboard, view:UITextView)
    {
        guard
        
            let lastState:MKeyboardState = model.states.last
        
        else
        {
            return
        }
        
        if lastState.needsUpdate
        {
            lastState.needsUpdate = false
            view.text = lastState.editing
        }
    }
    
    func commitIfNeeded(model:MKeyboard, view:UITextView)
    {
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
        else
        {
            lastState.commitState(
                model:model,
                view:view)
        }
    }
}
