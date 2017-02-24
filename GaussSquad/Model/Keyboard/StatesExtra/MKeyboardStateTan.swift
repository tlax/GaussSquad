import UIKit

class MKeyboardStateTan:MKeyboardStateExtra
{
    override func unflowedCommitState(model:MKeyboard, view:UITextView)
    {
        let sinValue:Double = tan(currentValue)
        editing = model.numberAsString(scalar:sinValue)
        
        view.text = model.kEmpty
        view.insertText(editing)
        
        let currentString:String = model.numberAsString(
            scalar:currentValue)
        
        commitingDescription = "\(kTabSpace)rad tan(\(currentString)) = \(editing)"
    }
}
