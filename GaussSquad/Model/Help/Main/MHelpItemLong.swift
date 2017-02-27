import UIKit

class MHelpItemLong:MHelpItem
{
    let title:NSAttributedString
    
    init(image:UIImage, title:NSAttributedString)
    {
        self.title = title
        let reusableIdentifier:String = VHelpCellLong.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            image:image)
    }
}
