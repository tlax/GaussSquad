import UIKit

class MKeyboardStateSin:MKeyboardStateExtra
{
    override func unflowedCommitState(model:MKeyboard, view:UITextView)
    {
        let sinValue:Double = sin(currentValue)
        editing = model.numberAsString(scalar:sinValue)
        
        view.text = model.kEmpty
        view.insertText(editing)
        
        let currentString:String = model.numberAsString(
            scalar:currentValue)
        
        commitingDescription = "\(kTabSpace)rad sin(\(currentString)) = \(editing)"
    }
}
