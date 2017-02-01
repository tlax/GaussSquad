import UIKit

class MLinearEquationsProjectRowItemEquals:MLinearEquationsProjectRowItem
{
    private let kCellWidth:CGFloat = 35
    
    init(polynomial:DPolynomial)
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellEquals.reusableIdentifier
        
        super.init(
            polynomial:polynomial,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
