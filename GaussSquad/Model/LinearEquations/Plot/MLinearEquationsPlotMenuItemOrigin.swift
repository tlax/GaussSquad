import UIKit

class MLinearEquationsPlotMenuItemOrigin:MLinearEquationsPlotMenuItem
{
    private let kCellWidth:CGFloat = 80
    private let kPositionX:CGFloat = 0
    private let kPositionY:CGFloat = 0
    
    init()
    {
        let reusableIdentifier:String = VLinearEquationsPlotMenuCellOrigin.reusableIdentifier
        
        super.init(
            positionX:kPositionX,
            positionY:kPositionY,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
