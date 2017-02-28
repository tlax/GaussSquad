import UIKit

class MKeyboardRowItemHide:MKeyboardRowItem
{
    init()
    {
        super.init(icon:#imageLiteral(resourceName: "assetKeyboardHide"))
    }
    
    override func selected(model:MKeyboard, view:UITextView)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
    }
}
