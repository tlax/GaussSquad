import UIKit

class MLinearEquationsProjectRowItemNewRow:MLinearEquationsProjectRowItem
{
    private weak var equation:DEquation?
    private let kCellWidth:CGFloat = 40
    
    init(equation:DEquation)
    {
        self.equation = equation
        let reusableIdentifier:String = VLinearEquationsProjectCellNewPolynomial.reusableIdentifier
        
        super.init(
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
