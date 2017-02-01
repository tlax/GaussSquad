import UIKit

class MLinearEquationsProjectRowItemOperator:MLinearEquationsProjectRowItem
{
    let image:UIImage?
    private let kCellWidth:CGFloat = 50
    
    init(
        polynomial:DPolynomial,
        image:UIImage?)
    {
        self.image = image
        let reusableIdentifier:String = VLinearEquationsProjectCellOperator.reusableIdentifier
        
        super.init(
            polynomial:polynomial,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
