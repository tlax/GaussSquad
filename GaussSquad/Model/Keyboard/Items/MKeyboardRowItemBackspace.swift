import UIKit

class MKeyboardRowItemBackspace:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardBackspace"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        view.deleteBackward()
        model.states.last?.editing = view.text
    }
}
