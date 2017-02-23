import UIKit

class MKeyboardRowItemDot:MKeyboardRowItem
{   
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardDot"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        updateIfNeeded(model:model, view:view)
        
        let current:String = view.text
        
        if !current.contains(model.kDot)
        {
            view.insertText(model.kDot)
            let newText:String = view.text
            model.states.last?.editing = newText
        }
    }
}
