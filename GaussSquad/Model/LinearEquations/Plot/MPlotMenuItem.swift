import UIKit

class MPlotMenuItem
{
    let color:UIColor
    let title:String
    let positionX:CGFloat
    let positionY:CGFloat
    
    init(
        color:UIColor,
        title:String,
        positionX:CGFloat,
        positionY:CGFloat)
    {
        self.color = color
        self.title = title
        self.positionX = positionX
        self.positionY = positionY
    }
}
