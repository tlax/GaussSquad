import UIKit

class MKeyboardStateSinDeg:MKeyboardStateExtra
{
    override func unflowedCommitState(model:MKeyboard, view:UITextView)
    {
        let sinValue:Double = sin(currentValue) * 180 / M_PI
        editing = model.numberAsString(scalar:sinValue)
        
        view.text = model.kEmpty
        view.insertText(editing)
        
        let currentString:String = model.numberAsString(
            scalar:currentValue)
        
        commitingDescription = "\(kTabSpace)deg sin(\(currentString)) = \(editing)"
    }
}
