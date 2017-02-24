import UIKit

class MKeyboardRowItemDivide:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardDivide"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        model.commitIfNeeded(view:view)
        
        let previousValue:Double = model.lastNumber()
        let stateDivide:MKeyboardStateDivide = MKeyboardStateDivide(
            previousValue:previousValue,
            editing:model.kInitial)
        model.states.append(stateDivide)
    }
}
