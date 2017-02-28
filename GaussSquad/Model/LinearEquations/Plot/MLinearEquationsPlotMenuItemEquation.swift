import UIKit

class MLinearEquationsPlotMenuItemEquation:MLinearEquationsPlotMenuItem
{
    let title:NSAttributedString
    let color:UIColor
    let value:Double
    
    init(
        title:NSAttributedString,
        color:UIColor,
        value:Double,
        positionX:CGFloat,
        positionY:CGFloat,
        cellWidth:CGFloat)
    {
        self.title = title
        self.value = value
        self.color = color
        let reusableIdentifier:String = VLinearEquationsPlotMenuCellEquation.reusableIdentifier
        
        super.init(
            positionX:positionX,
            positionY:positionY,
            cellWidth:cellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
