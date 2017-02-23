import UIKit

class MKeyboardRowItem3:MKeyboardRowItemNumeric
{
    private let kNumber:String = "3"
    
    init()
    {
        super.init(number:kNumber, icon:#imageLiteral(resourceName: "assetKeyboard3"))
    }
}
