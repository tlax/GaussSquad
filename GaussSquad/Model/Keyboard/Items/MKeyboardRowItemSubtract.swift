import UIKit

class MKeyboardRowItemSubtract:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardSubtract"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        model.commitIfNeeded(view:view)
        
        let previousValue:Double = model.lastNumber()
        let stateSubtract:MKeyboardStateSubtract = MKeyboardStateSubtract(
            previousValue:previousValue,
            editing:model.kInitial)
        model.states.append(stateSubtract)
    }
}
