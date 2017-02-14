import UIKit

class MLinearEquationsProjectControlsItem
{
    let image:UIImage
    private weak var row:MLinearEquationsProjectRow?
    
    init(
        image:UIImage,
        row:MLinearEquationsProjectRow)
    {
        self.image = image
        self.row = row
    }
}
