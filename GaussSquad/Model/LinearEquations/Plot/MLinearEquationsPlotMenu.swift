import UIKit

class MLinearEquationsPlotMenu
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
                 value:Double,
                 positionX:Double,
                 positionY:Double)
    {
        let floatX:CGFloat = CGFloat(positionX)
        let floatY:CGFloat = CGFloat(positionY)
        
        let item:MPlotMenuItemEquation = MPlotMenuItemEquation(
            color:color,
            title:title,
            value:value,
            positionX:floatX,
            positionY:floatY)
        
        items.append(item)
    }
}
