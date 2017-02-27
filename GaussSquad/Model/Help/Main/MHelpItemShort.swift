import UIKit

class MHelpItemShort:MHelpItem
{
    init(image:UIImage, title:String)
    {
        let reusableIdentifier:String = ""
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            image:image,
            title:title)
    }
}
