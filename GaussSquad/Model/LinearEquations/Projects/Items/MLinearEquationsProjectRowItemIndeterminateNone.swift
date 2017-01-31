import UIKit

class MLinearEquationsProjectRowItemIndeterminateNone:MLinearEquationsProjectRowItemIndeterminate
{
    private let kCellWidth:CGFloat = 50
    
    init(
        polynomial:DPolynomial?,
        column:Int)
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellIndeterminateSymbol.reusableIdentifier
        
        super.init(
            polynomial:polynomial,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier,
            column:column)
    }
}
