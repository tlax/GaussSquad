import UIKit

class MKeyboardRowItemNumeric:MKeyboardRowItem
{
    private let number:Double
    
    init(number:Double, icon:UIImage)
    {
        self.number = number
        super.init(icon:icon)
    }
    
    override func selected(model:MKeyboard)
    {
        guard
        
            let currentState:MKeyboardState = model.states.last
        
        else
        {
            return
        }
        
        if currentState.decimalPoint
        {
            
        }
        else
        {
            let currentNumber:Double = currentState.editingNumber
            let numberAnSpace:Double = currentNumber * 10
            let newNumber:Double = numberAnSpace + number
            currentState.editingNumber = newNumber
        }
    }
}
