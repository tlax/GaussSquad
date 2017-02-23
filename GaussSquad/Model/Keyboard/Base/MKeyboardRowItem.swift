import UIKit

class MKeyboardRowItem
{
    let icon:UIImage
    let kEmpty:String = ""
    let kSign:String = "-"
    let kInitial:String = "0"
    let kDot:String = "."
    
    init(icon:UIImage)
    {
        self.icon = icon
    }
    
    //MARK: public
    
    func selected(
        model:MKeyboard,
        view:UITextView)
    {
        
    }
}
