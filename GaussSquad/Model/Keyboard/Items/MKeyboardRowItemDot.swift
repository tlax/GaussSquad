import UIKit

class MKeyboardRowItemDot:MKeyboardRowItem
{   
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardDot"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        let current:String = view.text
        
        if !current.contains(kDot)
        {
            view.insertText(kDot)
            let newText:String = view.text
            model.states.last?.editing = newText
        }
    }
}
