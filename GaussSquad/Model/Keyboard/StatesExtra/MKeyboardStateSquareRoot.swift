import UIKit

class MKeyboardStateSquareRoot:MKeyboardStateExtra
{
    override func unflowedCommitState(model:MKeyboard, view:UITextView)
    {
        let rootValue:Double = sqrt(currentValue)
        editing = model.numberAsString(scalar:rootValue)
        
        view.text = model.kEmpty
        view.insertText(editing)
        
        let currentString:String = model.numberAsString(
            scalar:currentValue)
        
        commitingDescription = "\(kTabSpace)square root (\(currentString)) = \(editing)"
    }
}
