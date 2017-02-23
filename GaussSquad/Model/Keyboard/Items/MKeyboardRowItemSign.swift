import UIKit

class MKeyboardRowItemSign:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardSign"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        updateIfNeeded(model:model, view:view)
        
        var current:String = view.text
        
        if current.contains(model.kSign)
        {
            current = current.replacingOccurrences(
                of:model.kSign,
                with:model.kEmpty)
        }
        else
        {
            current = "\(model.kSign)\(current)"
        }
        
        view.text = model.kEmpty
        view.insertText(current)
        model.states.last?.editing = current
    }
}
