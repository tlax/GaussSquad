import UIKit

class MLinearEquationsProjectRowItemIndex:MLinearEquationsProjectRowItem
{
    let index:Int
    private let kCellWidth:CGFloat = 50
    private let kColumn:Int = 0
    
    init(
        polynomial:DPolynomial?,
        index:Int)
    {
        self.index = index
        let reusableIdentifier:String = VLinearEquationsProjectCellEquals.reusableIdentifier
        
        super.init(
            polynomial:polynomial,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier,
            column:kColumn)
    }
}
