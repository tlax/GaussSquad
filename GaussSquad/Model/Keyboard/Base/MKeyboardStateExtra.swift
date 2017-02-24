import UIKit

class MKeyboardStateExtra:MKeyboardState
{
    let currentValue:Double
    private let kNeedsUpdate:Bool = false
    private let kEmpty:String = ""
    
    init(currentValue:Double)
    {
        self.currentValue = currentValue
        super.init(
            editing:kEmpty,
            needsUpdate:kNeedsUpdate)
    }
}
