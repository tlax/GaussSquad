import UIKit

class MKeyboardRowItemMultiply:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardMultiply"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
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
            model.states.last?.commitState(
                model:model,
                view:view)
        }
        
        let previousValue:Double = model.lastNumber()
        let stateMultiply:MKeyboardStateMultiply = MKeyboardStateMultiply(
            previousValue:previousValue,
            editing:model.kInitial)
        model.states.append(stateMultiply)
    }
}
