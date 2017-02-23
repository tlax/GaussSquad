import Foundation

class MKeyboardStateAdd:MKeyboardState
{
    private let previousValue:Double
    
    init(previousValue:Double, editing:String)
    {
        self.previousValue = previousValue
        super.init(editing:editing)
    }
}
