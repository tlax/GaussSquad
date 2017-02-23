import Foundation

class MKeyboardStatePlain:MKeyboardState
{
    private let kNeedsUpdate:Bool = false
    
    init(editing:String)
    {
        super.init(
            editing:editing,
            needsUpdate:kNeedsUpdate)
    }
}
