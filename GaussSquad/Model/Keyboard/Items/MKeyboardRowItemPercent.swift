import UIKit

class MKeyboardRowItemPercent:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardPercent"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        let currentString:String = view.text
        let scalar:Double = model.stringAsNumber(string:currentString)
        let percent:Double = scalar / 100
        let newString:String = model.numberAsString(scalar:percent)
        
        view.text = model.kEmpty
        view.insertText(newString)
        model.states.last?.editing = newString
    }
}
