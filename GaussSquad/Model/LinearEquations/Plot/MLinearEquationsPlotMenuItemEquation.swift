import UIKit

class MLinearEquationsPlotMenuItemEquation:MPlotMenuItem
{
    let color:UIColor
    let value:Double
    private let kCellWidth:CGFloat = 200
    
    init(
        color:UIColor,
        title:String,
        value:Double,
        positionX:CGFloat,
        positionY:CGFloat)
    {
        self.value = value
        self.color = color
        
        super.init(
            color:color,
            title:title,
            positionX:positionX,
            positionY:positionY)
    }
}
