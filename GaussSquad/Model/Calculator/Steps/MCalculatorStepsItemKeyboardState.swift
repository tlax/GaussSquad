import Foundation

class MCalculatorStepsItemKeyboardState:MCalculatorStepsItem
{
    weak var keyboardState:MKeyboardState?
    
    init(keyboardState:MKeyboardState)
    {
        self.keyboardState = keyboardState
        
        super.init(itemDescr:keyboardState.commitingDescription)
    }
}
