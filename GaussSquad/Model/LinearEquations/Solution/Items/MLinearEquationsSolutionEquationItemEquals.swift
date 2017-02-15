import UIKit

class MLinearEquationsSolutionEquationItemEquals:MLinearEquationsSolutionEquationItem
{
    let image:UIImage
    private let kCellWidth:CGFloat = 20
    private let kEquals:String = "="
    
    init()
    {
        image = #imageLiteral(resourceName: "assetGenericColEqualsSmall")
        let reusableIdentifier:String =  VLinearEquationsSolutionCellEquals.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:kCellWidth)
    }
    
    override func shareText() -> String?
    {
        return kEquals
    }
    
    override func drawInRect(rect:CGRect)
    {
        let imageWidth:CGFloat = image.size.width
        let imageHeight:CGFloat = image.size.height
        let remainTop:CGFloat = rect.size.height - imageHeight
        let remainLeft:CGFloat = rect.size.width - imageWidth
        let marginTop:CGFloat = remainTop / 2.0
        let marginLeft:CGFloat = remainLeft / 2.0
        let posX:CGFloat = marginLeft + rect.origin.x
        let posY:CGFloat = marginTop + rect.origin.y
        
        let rect:CGRect = CGRect(
            x:posX,
            y:posY,
            width:imageWidth,
            height:imageHeight)
        
        image.draw(in:rect)
    }
}
