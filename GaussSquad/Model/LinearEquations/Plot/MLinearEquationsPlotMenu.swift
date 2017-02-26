import UIKit

class MLinearEquationsPlotMenu
{
    private(set) var items:[MLinearEquationsPlotMenuItem]
    private let attributes:[String:AnyObject]
    private let drawingOptions:NSStringDrawingOptions
    private let maxSize:CGSize
    private let kMaxWidth:CGFloat = 200
    private let kMaxHeight:CGFloat = 20
    private let kAddedWidth:CGFloat = 55
    
    init()
    {
        attributes = [
            NSFontAttributeName:UIFont.bold(size:16),
            NSForegroundColorAttributeName:UIColor.black]
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesLineFragmentOrigin,
            NSStringDrawingOptions.usesFontLeading])
        maxSize = CGSize(width:kMaxWidth, height:kMaxHeight)
        
        let itemOrigin:MLinearEquationsPlotMenuItemOrigin = MLinearEquationsPlotMenuItemOrigin()
        items = [itemOrigin]
    }
    
    //MARK: public
    
    func addItem(
        title:String,
        color:UIColor,
        value:Double,
        positionX:Double,
        positionY:Double)
    {
        let floatX:CGFloat = CGFloat(positionX)
        let floatY:CGFloat = CGFloat(positionY)
        
        let attributedTitle:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributes)
        let textRect:CGRect = attributedTitle.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let textWidth:CGFloat = ceil(textRect.size.width)
        let cellWidth:CGFloat = textWidth + kAddedWidth
        
        let item:MLinearEquationsPlotMenuItemEquation = MLinearEquationsPlotMenuItemEquation(
            title:attributedTitle,
            color:color,
            value:value,
            positionX:floatX,
            positionY:floatY,
            cellWidth:cellWidth)
        
        items.append(item)
    }
}
