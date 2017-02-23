import Foundation

class MKeyboardState
{
    var editingNumber:Double
    var decimalPoint:Bool
    let number:Double
    
    init(number:Double)
    {
        self.number = number
        editingNumber = 0
        decimalPoint = false
    }
}
