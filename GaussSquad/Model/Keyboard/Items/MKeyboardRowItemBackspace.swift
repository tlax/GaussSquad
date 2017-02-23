import UIKit

class MKeyboardRowItemBackspace:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardBackspace"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        let current:String = view.text
        let countCurrent:Int = current.characters.count
        
        if countCurrent < 3
        {
            if current.contains(kSign)
            {
                view.text = kEmpty
                view.insertText(kInitial)
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
