import UIKit

class MLinearEquationsProjectRowItemIndeterminateNone:MLinearEquationsProjectRowItemIndeterminate
{
    private let kCellWidth:CGFloat = 50
    
    init(column:Int)
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellIndeterminateSymbol.reusableIdentifier
        
        super.init(
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier,
            column:column)
    }
}
