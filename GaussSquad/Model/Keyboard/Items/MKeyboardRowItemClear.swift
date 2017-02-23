import UIKit

class MKeyboardRowItemClear:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardClear"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        if let _:MKeyboardStatePlain = model.states.last as? MKeyboardStatePlain
        {
            model.states.last?.editing = model.kInitial
        }
        else
        {
            let newState:MKeyboardStatePlain = MKeyboardStatePlain(
                editing:model.kInitial)
            model.states.append(newState)
        }
        
        view.text = model.kEmpty
        view.insertText(model.kInitial)
    }
}
