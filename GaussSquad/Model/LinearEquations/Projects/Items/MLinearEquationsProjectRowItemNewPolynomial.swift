import UIKit

class MLinearEquationsProjectRowItemNewPolynomial:MLinearEquationsProjectRowItem
{
    private let kCellWidth:CGFloat = 60
    
    init()
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellNewPolynomial.reusableIdentifier
        
        super.init(
            polynomial:nil,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
