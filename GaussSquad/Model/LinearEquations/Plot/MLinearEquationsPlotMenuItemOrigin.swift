import UIKit

class MLinearEquationsPlotMenuItemOrigin:MLinearEquationsPlotMenuItem
{
    private let kCellWidth:CGFloat = 70
    private let kPositionX:CGFloat = 0
    private let kPositionY:CGFloat = 0
    
    init()
    {
        let reusableIdentifier:String = VLinearEquationsPlotMenuCellOrigin.reusableIdentifier
        
        super.init(
            positionX:positionX,
            positionY:positionY,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
