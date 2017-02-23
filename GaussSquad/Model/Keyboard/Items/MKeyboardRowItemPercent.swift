import UIKit

class MKeyboardRowItemPercent:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardPercent"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        commitIfNeeded(model:model, view:view)
        
        let previousValue:Double = model.lastNumber()
        let stateMultiply:MKeyboardStateMultiply = MKeyboardStateMultiply(
            previousValue:previousValue,
            editing:model.kInitial)
        model.states.append(stateMultiply)
    }
}
