import UIKit

class MLinearEquationsSolutionEquationItemIndex:MLinearEquationsSolutionEquationItem
{
    let index:Int
    let string:NSAttributedString
    let kMarginTop:CGFloat = 3
    let kMarginLeft:CGFloat = 10
    private let kCellWidth:CGFloat = 30
    private let kSeparator:String = ":"
    
    init(index:Int)
    {
        self.index = index
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:13),
            NSForegroundColorAttributeName:UIColor.squadBlue]
        let rawString:String = "\((index + 1))"
        string = NSAttributedString(
            string:rawString,
            attributes:attributes)
        
        let reusableIdentifier:String =  VLinearEquationsSolutionCellIndex.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:kCellWidth)
    }
    
    override func shareText() -> String?
    {
        let text:String = "\(string.string)\(kSeparator)"
        
        return text
    }
}
