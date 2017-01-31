import UIKit

class MLinearEquationsProjectRowItemOperator:MLinearEquationsProjectRowItem
{
    let image:UIImage?
    private let kCellWidth:CGFloat = 50
    
    init(
        image:UIImage?,
        column:Int)
    {
        self.image = image
        let reusableIdentifier:String = VLinearEquationsProjectCellOperator.reusableIdentifier
        
        super.init(
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier,
            column:column)
    }
}