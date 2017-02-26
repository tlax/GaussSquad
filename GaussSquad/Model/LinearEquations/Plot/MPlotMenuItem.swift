import UIKit

class MPlotMenuItem
{
    let positionX:CGFloat
    let positionY:CGFloat
    let cellWidth:CGFloat
    let reusableIdentifier:String
    
    init(
        positionX:CGFloat,
        positionY:CGFloat,
        cellWidth:CGFloat,
        reusableIdentifier:String)
    {
        self.positionX = positionX
        self.positionY = positionY
        self.cellWidth = cellWidth
        self.reusableIdentifier = reusableIdentifier
    }
}
