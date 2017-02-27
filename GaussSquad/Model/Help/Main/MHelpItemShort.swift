import UIKit

class MHelpItemShort:MHelpItem
{
    let title:String
    
    init(image:UIImage, title:String)
    {
        self.title = title
        let reusableIdentifier:String = VHelpCellShort.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            image:image)
    }
}
