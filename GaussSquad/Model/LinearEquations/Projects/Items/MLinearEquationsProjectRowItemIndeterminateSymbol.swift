import UIKit

class MLinearEquationsProjectRowItemIndeterminateSymbol:MLinearEquationsProjectRowItemIndeterminate
{
    let attributedString:NSAttributedString
    private let kFontSize:CGFloat = 25
    private let kMaxHeight:CGFloat = 30
    private let kMaxWidth:CGFloat = 5000
    private let kStringMargin:CGFloat = 30
    
    init(
        polynomial:DPolynomial?,
        symbol:String,
        column:Int)
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellIndeterminateSymbol.reusableIdentifier
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
            polynomial:polynomial,
            cellWidth:cellWidth,
            reusableIdentifier:reusableIdentifier,
            column:column)
    }
}
