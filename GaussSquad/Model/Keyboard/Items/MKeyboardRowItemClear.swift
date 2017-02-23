import UIKit

class MKeyboardRowItemClear:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardClear"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        view.text = kEmpty
        view.insertText(kInitial)
        model.states.last?.editing = kInitial
    }
}
