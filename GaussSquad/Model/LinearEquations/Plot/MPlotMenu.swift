import UIKit

class MPlotMenu
{
    private(set) var items:[MPlotMenuItem]
    
    init()
    {
        let itemOrigin:MPlotMenuItemOrigin = MPlotMenuItemOrigin()
        items = [itemOrigin]
    }
    
    //MARK: public
    
    func addItem(color:UIColor,
                 title:String,
                 positionX:Double,
                 positionY:Double)
    {
        let floatX:CGFloat = CGFloat(positionX)
        let floatY:CGFloat = CGFloat(positionY)
        
        let item:MPlotMenuItem = MPlotMenuItem(
            color:color,
            title:title,
            positionX:floatX,
            positionY:floatY)
        
        items.append(item)
    }
}
