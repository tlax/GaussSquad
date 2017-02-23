import Foundation

class MKeyboardStateAdd:MKeyboardState
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
}
