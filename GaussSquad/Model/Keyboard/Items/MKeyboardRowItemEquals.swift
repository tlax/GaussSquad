import UIKit

class MKeyboardRowItemEquals:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardEquals"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        print(model.lastString())
        
        model.states.last?.commitState(
            model:model,
            view:view)
    }
}
