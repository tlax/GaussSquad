import UIKit

class MKeyboardRowItem1:MKeyboardRowItemNumeric
{
    private let kNumber:String = "1"
    
    init()
    {
        super.init(number:kNumber, icon:#imageLiteral(resourceName: "assetKeyboard1"))
    }
}
