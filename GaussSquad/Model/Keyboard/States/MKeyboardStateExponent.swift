import UIKit

class MKeyboardStateExponent:MKeyboardState
{
    private let previousValue:Double
    private let kNeedsUpdate:Bool = true
    
    init(previousValue:Double, editing:String)
    {
        self.previousValue = previousValue
        super.init(
            editing:editing,
            needsUpdate:kNeedsUpdate)
    }
    
    override func commitState(model:MKeyboard, view:UITextView)
    {
        let currentValue:Double = model.lastNumber()
        let newValue:Double = pow(previousValue, currentValue)
        editing = model.numberAsString(scalar:newValue)
        
        view.text = model.kEmpty
        view.insertText(editing)
        
        let currentString:String = model.numberAsString(
            scalar:currentValue)
        
        commitingDescription = "^ \(currentString) = \(editing)"
    }
}
