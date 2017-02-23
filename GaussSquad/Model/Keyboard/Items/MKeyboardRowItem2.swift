import UIKit

class MKeyboardRowItem2:MKeyboardRowItemNumeric
{
    private let kNumber:Double = 2
    
    init()
    {
        super.init(number:kNumber, icon:#imageLiteral(resourceName: "assetKeyboard2"))
    }
}
