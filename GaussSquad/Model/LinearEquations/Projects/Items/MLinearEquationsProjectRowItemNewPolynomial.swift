import UIKit

class MLinearEquationsProjectRowItemNewPolynomial:MLinearEquationsProjectRowItem
{
    weak var equation:DEquation?
    private let kCellWidth:CGFloat = 60
    
    init(equation:DEquation)
    {
        self.equation = equation
        let reusableIdentifier:String = VLinearEquationsProjectCellNewPolynomial.reusableIdentifier
        
        super.init(
            polynomial:nil,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
