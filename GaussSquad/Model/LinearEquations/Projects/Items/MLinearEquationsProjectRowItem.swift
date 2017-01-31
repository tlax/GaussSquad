import UIKit

class MLinearEquationsProjectRowItem
{
    let cellWidth:CGFloat
    let reusableIdentifier:String
    let column:Int
    
    init(
        cellWidth:CGFloat,
        reusableIdentifier:String,
        column:Int)
    {
        self.cellWidth = cellWidth
        self.reusableIdentifier = reusableIdentifier
        self.column = column
    }
    
    //MARK: public
    
    func selected(controller:CLinearEquationsProject)
    {
        
    }
}
