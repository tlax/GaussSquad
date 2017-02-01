import UIKit

class MLinearEquationsProjectRowItemIndex:MLinearEquationsProjectRowItem
{
    let index:Int
    private let kCellWidth:CGFloat = 50
    
    init(
        polynomial:DPolynomial?,
        index:Int)
    {
        self.index = index
        let reusableIdentifier:String = VLinearEquationsProjectCellIndex.reusableIdentifier
        
        super.init(
            polynomial:polynomial,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
