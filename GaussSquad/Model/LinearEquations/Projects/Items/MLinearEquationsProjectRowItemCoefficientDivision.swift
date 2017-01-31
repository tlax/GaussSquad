import UIKit

class MLinearEquationsProjectRowItemCoefficientDivision:MLinearEquationsProjectRowItemCoefficient
{
    let attributedStringDividend:NSAttributedString
    let attributedStringDivisor:NSAttributedString
    private let kFontSize:CGFloat = 20
    private let kMaxHeight:CGFloat = 30
    private let kMaxWidth:CGFloat = 5000
    private let kStringMargin:CGFloat = 20
    
    init(
        polynomial:DPolynomial,
        column:Int)
    {
        let reusableIdentifier:String = VLinearEquationsProjectCellCoefficientDivision.reusableIdentifier
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kFontSize)]
        let maxSize:CGSize = CGSize(
            width:kMaxWidth,
            height:kMaxHeight)
        let rawStringDividend:String = "\(coefficientDividend)"
        let rawStringDivisor:String = "\(coefficientDivisor)"
        
        attributedStringDividend = NSAttributedString(
            string:rawStringDividend,
            attributes:attributes)
        attributedStringDivisor = NSAttributedString(
            string:rawStringDivisor,
            attributes:attributes)
        
        let stringRectDividend:CGRect = attributedStringDividend.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let stringRectDivisor:CGRect = attributedStringDivisor.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        
        let stringWidthDividend:CGFloat = ceil(stringRectDividend.size.width)
        let stringWidthDivisor:CGFloat = ceil(stringRectDivisor.size.width)
        let stringWidth:CGFloat = max(stringWidthDividend, stringWidthDivisor)
        let cellWidth:CGFloat = stringWidth + kStringMargin
        
        super.init(
            polynomial:polynomial,
            cellWidth:cellWidth,
            reusableIdentifier:reusableIdentifier,
            column:column)
    }
}
