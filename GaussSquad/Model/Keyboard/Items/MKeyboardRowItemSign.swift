import UIKit

class MKeyboardRowItemSign:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardSign"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        var current:String = view.text
        
        if current.contains(kSign)
        {
            current = current.replacingOccurrences(of:kSign, with:kEmpty)
        }
        else
        {
            current = "\(kSign)\(current)"
        }
        
        view.text = kEmpty
        view.insertText(current)
        model.states.last?.editing = current
    }
}
