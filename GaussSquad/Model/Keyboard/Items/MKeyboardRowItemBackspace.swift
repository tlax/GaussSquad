import UIKit

class MKeyboardRowItemBackspace:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardBackspace"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        model.updateIfNeeded(view:view)
        
        let current:String = view.text
        let countCurrent:Int = current.characters.count
        
        if countCurrent < 3
        {
            if current.contains(model.kSign) || current.contains(model.kInfinitum) || countCurrent == 1
            {
                view.text = model.kEmpty
                view.insertText(model.kInitial)
            }
            else
            {
                view.deleteBackward()
            }
        }
        else
        {
            view.deleteBackward()
        }
        
        let newText:String = view.text
        model.states.last?.editing = newText
    }
}
