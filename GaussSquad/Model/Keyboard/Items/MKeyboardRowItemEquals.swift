import UIKit

class MKeyboardRowItemEquals:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardEquals"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        commitIfNeeded(model:model, view:view)
        
        let previousString:String = model.lastString()
        let statePlain:MKeyboardStatePlain = MKeyboardStatePlain(
            editing:previousString)
        model.states.append(statePlain)
    }
}
