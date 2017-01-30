import UIKit

class MLinearEquationsProjectBarItemReport:MLinearEquationsProjectBarItem
{
    let image:UIImage
    let title:String
    let count:String
    
    init(
        image:UIImage,
        title:String,
        count:String)
    {
        let reusableIdentifier:String = VLinearEquationsBarCellReport.reusableIdentifier
        self.image = image
        self.title = title
        self.count = count
        
        super.init(reusableIdentifier:reusableIdentifier)
    }
}
