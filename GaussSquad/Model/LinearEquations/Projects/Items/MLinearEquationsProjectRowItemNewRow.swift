import UIKit

class MLinearEquationsProjectRowItemNewRow:MLinearEquationsProjectRowItem
{
    private let kCellWidth:CGFloat = 54
    
    init()
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellNewRow.reusableIdentifier
        
        super.init(
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
    
    override func selected(
        controller:CLinearEquationsProject,
        index:IndexPath)
    {
        controller.model.createRow()
    }
}
