import UIKit

class MPlotMenuItemOrigin:MPlotMenuItem
{
    private let kPositionX:CGFloat = 0
    private let kPositionY:CGFloat = 0
    
    init()
    {
        let title:String = NSLocalizedString("MPlotMenuItemOrigin_title", comment:"")
        let color:UIColor = UIColor.black
        
        super.init(
            color:color,
            title:title,
            positionX:kPositionX,
            positionY:kPositionY)
    }
}
