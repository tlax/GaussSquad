import UIKit

class MLinearEquationsPlotMenuItemEquation:MLinearEquationsPlotMenuItem
{
    let color:UIColor
    let title:String
    let value:Double
    private let kCellWidth:CGFloat = 150
    
    init(
        color:UIColor,
        title:String,
        value:Double,
        positionX:CGFloat,
        positionY:CGFloat)
    {
        self.value = value
        self.title = title
        self.color = color
        let reusableIdentifier:String = VLinearEquationsPlotMenuCellEquation.reusableIdentifier
        
        super.init(
            positionX:positionX,
            positionY:positionY,
            cellWidth:kCellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
