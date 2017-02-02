import UIKit

class MLinearEquationsProjectRowItemIndex:MLinearEquationsProjectRowItem
{
    private let kCellWidth:CGFloat = 40
    
    init()
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellIndex.reusableIdentifier
        
        super.init(
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
