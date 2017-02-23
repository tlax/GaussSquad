import UIKit

class MKeyboardRowItemClear:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardClear"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        view.text = model.kEmpty
        view.insertText(model.kInitial)
        model.states.last?.editing = model.kInitial
    }
}
