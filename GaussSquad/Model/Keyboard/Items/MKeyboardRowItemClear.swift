import UIKit

class MKeyboardRowItemClear:MKeyboardRowItem
{
    private let kEmpty:String = ""
    private let kInitial:String = "0"
    
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
