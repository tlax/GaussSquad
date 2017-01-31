import UIKit

class MLinearEquationsProjectBarItemButton:MLinearEquationsProjectBarItem
{
    let image:UIImage
    
    init(image:UIImage)
    {
        let reusableIdentifier:String = VLinearEquationsBarCellButton.reusableIdentifier
        self.image = image
        
        super.init(reusableIdentifier:reusableIdentifier)
    }
}
