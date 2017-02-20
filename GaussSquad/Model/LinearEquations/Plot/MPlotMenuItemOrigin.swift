import UIKit

class MPlotMenuItemOrigin:MPlotMenuItem
{
    private let kTitle:String = ""
    private let kPositionX:CGFloat = 0
    private let kPositionY:CGFloat = 0
    
    init()
    {
        let color:UIColor = UIColor.black
        
        super.init(
            color:color,
            title:kTitle,
            positionX:kPositionX,
            positionY:kPositionY)
    }
}
