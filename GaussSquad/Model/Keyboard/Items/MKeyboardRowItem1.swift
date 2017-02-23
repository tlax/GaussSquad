import UIKit

class MKeyboardRowItem1:MKeyboardRowItemNumeric
{
    private let kNumber:Double = 1
    
    init()
    {
        super.init(number:kNumber, icon:#imageLiteral(resourceName: "assetKeyboard1"))
    }
}
