import UIKit

class MKeyboardRowItemNumeric:MKeyboardRowItem
{
    private let number:String
    
    init(number:String, icon:UIImage)
    {
        self.number = number
        super.init(icon:icon)
    }
    
    override func selected(
        model:MKeyboard,
        field:UIKeyInput)
    {
        
    }
}
