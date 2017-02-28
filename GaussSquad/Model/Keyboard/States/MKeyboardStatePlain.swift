import UIKit

class MKeyboardStatePlain:MKeyboardState
{
    private let kNeedsUpdate:Bool = false
    
    init(editing:String)
    {
        super.init(
            editing:editing,
            needsUpdate:kNeedsUpdate)
    }
    
    override func commitState(model:MKeyboard, view:UITextView)
    {
        commitingDescription = model.lastString()
    }
}
