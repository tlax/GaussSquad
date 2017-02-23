import UIKit

class MKeyboardRowItemBackspace:MKeyboardRowItem
{
    private let kInitial:String = "0"
    
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardBackspace"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        view.deleteBackward()
        
        var current:String = view.text
        
        if current.isEmpty
        {
            current = kInitial
            view.insertText(current)
        }
        
        model.states.last?.editing = current
    }
}
