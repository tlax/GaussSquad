import UIKit

class MKeyboardState
{
    var editing:String
    var needsUpdate:Bool
    var commitingDescription:String
    private let kEmpty:String = ""
    
    init(
        editing:String,
        needsUpdate:Bool)
    {
        self.editing = editing
        self.needsUpdate = needsUpdate
        commitingDescription = kEmpty
    }
    
    //MARK: public
    
    func commitState(model:MKeyboard, view:UITextView)
    {
    }
    
    func undoBack(model:MKeyboard)
    {
        editing = model.kInitial
        needsUpdate = true
    }
}
