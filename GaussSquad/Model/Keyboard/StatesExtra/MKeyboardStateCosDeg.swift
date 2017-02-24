import UIKit

class MKeyboardStateCosDeg:MKeyboardStateExtra
{
    override func unflowedCommitState(model:MKeyboard, view:UITextView)
    {
        let sinValue:Double = cos(currentValue * M_PI / 180.0)
        editing = model.numberAsString(scalar:sinValue)
        
        view.text = model.kEmpty
        view.insertText(editing)
        
        let currentString:String = model.numberAsString(
            scalar:currentValue)
        
        commitingDescription = "\(kTabSpace)deg cos(\(currentString)) = \(editing)"
    }
}
