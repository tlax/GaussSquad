import UIKit

class MLinearEquationsProjectRowItemNewRow:MLinearEquationsProjectRowItem
{
    private let kCellWidth:CGFloat = 40
    
    init()
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellNewRow.reusableIdentifier
        
        super.init(
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
