import UIKit

class MLinearEquationsProjectRowItemIndex:MLinearEquationsProjectRowItem
{
    let index:Int
    private let kCellWidth:CGFloat = 40
    
    init(index:Int)
    {
        self.index = index
        let reusableIdentifier:String = VLinearEquationsProjectCellIndex.reusableIdentifier
        
        super.init(
            polynomial:nil,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
