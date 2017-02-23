import UIKit

class MKeyboardState
{
    var editing:String
    var needsUpdate:Bool
    
    init(
        editing:String,
        needsUpdate:Bool)
    {
        self.editing = editing
        self.needsUpdate = needsUpdate
    }
    
    //MARK: public
    
    func commitState(model:MKeyboard, view:UITextView)
    {
    }
}
