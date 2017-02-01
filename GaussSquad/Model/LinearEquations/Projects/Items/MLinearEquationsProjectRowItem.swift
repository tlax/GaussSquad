import UIKit

class MLinearEquationsProjectRowItem
{
    let cellWidth:CGFloat
    let reusableIdentifier:String
    
    init(
        cellWidth:CGFloat,
        reusableIdentifier:String)
    {
        self.cellWidth = cellWidth
        self.reusableIdentifier = reusableIdentifier
    }
    
    //MARK: public
    
    func selected(controller:CLinearEquationsProject)
    {
    }
}
