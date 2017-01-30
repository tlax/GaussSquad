import UIKit

class MLinearEquationsProjectRowItem
{
    var cellWidth:CGFloat
    var cellHeight:CGFloat
    let reusableIdentifier:String
    
    init(
        cellWidth:CGFloat,
        cellHeight:CGFloat,
        reusableIdentifier:String)
    {
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        self.reusableIdentifier = reusableIdentifier
    }
}
