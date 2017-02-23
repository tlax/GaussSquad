import UIKit

class MKeyboardRowItemMultiply:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardMultiply"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        model.states.last?.commitState(
            model:model,
            view:view)
        
        let previousValue:Double = model.lastNumber()
        let stateMultiply:MKeyboardStateMultiply = MKeyboardStateMultiply(
            previousValue:previousValue,
            editing:model.kInitial)
        model.states.append(stateMultiply)
    }
}
