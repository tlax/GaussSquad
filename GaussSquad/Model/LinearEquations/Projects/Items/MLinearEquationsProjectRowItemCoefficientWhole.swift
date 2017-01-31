import UIKit

class MLinearEquationsProjectRowItemCoefficientWhole:MLinearEquationsProjectRowItemCoefficient
{
    let attributedString:NSAttributedString
    private let kFontSize:CGFloat = 20
    private let kMaxHeight:CGFloat = 30
    private let kMaxWidth:CGFloat = 5000
    private let kStringMargin:CGFloat = 20
    
    init(
        polynomial:DPolynomial,
        column:Int)
    {
        let coefficient:Double = coefficientDividend / coefficientDivisor
        let reusableIdentifier:String = VLinearEquationsProjectCellCoefficientWhole.reusableIdentifier
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kFontSize)]
        let rawString:String = "\(coefficient)"
        attributedString = NSAttributedString(
            string:rawString,
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
