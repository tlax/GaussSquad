import UIKit

class MLinearEquationsProjectRowItemIndeterminate:MLinearEquationsProjectRowItem
{
    let attributedString:NSAttributedString
    private let kFontSize:CGFloat = 20
    private let kMaxHeight:CGFloat = 30
    private let kMaxWidth:CGFloat = 5000
    private let kStringMargin:CGFloat = 20
    
    init(symbol:String, column:Int)
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellIndeterminate.reusableIdentifier
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:kFontSize)]
        attributedString = NSAttributedString(
            string:symbol,
            attributes:attributes)
        
        let maxSize:CGSize = CGSize(
            width:kMaxWidth,
            height:kMaxHeight)
        let stringRect:CGRect = attributedString.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let stringWidth:CGFloat = ceil(stringRect.size.width)
        let cellWidth:CGFloat = stringWidth + kStringMargin
        
        super.init(
            cellWidth:cellWidth,
            reusableIdentifier:reusableIdentifier,
            column:column)
    }
}
