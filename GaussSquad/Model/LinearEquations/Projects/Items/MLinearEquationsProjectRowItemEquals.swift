import UIKit

class MLinearEquationsProjectRowItemEquals:MLinearEquationsProjectRowItem
{
    private let kCellWidth:CGFloat = 80
    
    init()
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellEquals.reusableIdentifier
        
        super.init(
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
