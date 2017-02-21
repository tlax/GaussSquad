import UIKit

class MPlotMenuItemEquation:MPlotMenuItem
{
    let value:Double
    
    init(
        color:UIColor,
        title:String,
        value:Double,
        positionX:CGFloat,
        positionY:CGFloat)
    {
        self.value = value
        
        super.init(
            color:color,
            title:title,
            positionX:positionX,
            positionY:positionY)
    }
}
