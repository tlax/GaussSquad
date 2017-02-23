import UIKit

class MKeyboardRowItemNumeric:MKeyboardRowItem
{
    private let number:Double
    
    init(number:Double, icon:UIImage)
    {
        self.number = number
        super.init(icon:icon)
    }
}
