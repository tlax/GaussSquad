import UIKit

class MLinearEquationsPlotMenu
{
    private(set) var items:[MLinearEquationsPlotMenuItem]
    
    init()
    {
        let itemOrigin:MLinearEquationsPlotMenuItemOrigin = MLinearEquationsPlotMenuItemOrigin()
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
        
        let item:MLinearEquationsPlotMenuItemEquation = MLinearEquationsPlotMenuItemEquation(
            color:color,
            title:title,
            value:value,
            positionX:floatX,
            positionY:floatY)
        
        items.append(item)
    }
}
