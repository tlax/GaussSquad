import UIKit

class MLinearEquationsProjectRowItemEquals:MLinearEquationsProjectRowItem
{
    private let kCellWidth:CGFloat = 30
    
    init()
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellEquals.reusableIdentifier
        
        super.init(
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
