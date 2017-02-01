import UIKit

class MLinearEquationsProjectRowItemEquals:MLinearEquationsProjectRowItem
{
    private let kCellWidth:CGFloat = 35
    
    init()
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellEquals.reusableIdentifier
        
        super.init(
            polynomial:nil,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
