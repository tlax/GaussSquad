import UIKit

class MHelpItemLong:MHelpItem
{
    init(image:UIImage, title:String)
    {
        let reusableIdentifier:String = VHelpCellLong.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            image:image,
            title:title)
    }
}
