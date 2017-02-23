import UIKit

class MKeyboardRowItemAdd:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardAdd"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        model.states.last?.commitState(
            model:model,
            view:view)
        
        let previousValue:Double = model.lastNumber()
        let stateAdd:MKeyboardStateAdd = MKeyboardStateAdd(
            previousValue:previousValue,
            editing:model.kInitial)
        model.states.append(stateAdd)
    }
}
