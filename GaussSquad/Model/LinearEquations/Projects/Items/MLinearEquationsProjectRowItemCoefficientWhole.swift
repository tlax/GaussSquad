import UIKit

class MLinearEquationsProjectRowItemCoefficientWhole:MLinearEquationsProjectRowItemCoefficient
{
    var attributedString:NSAttributedString
    
    init(
        polynomial:DPolynomial?,
        column:Int)
    {
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = MLinearEquationsProjectRowItemCoefficient.kNumberFormatterStyle
        numberFormatter.minimumIntegerDigits = MLinearEquationsProjectRowItemCoefficient.kMinIntegers
        numberFormatter.maximumIntegerDigits = MLinearEquationsProjectRowItemCoefficient.kMaxIntegers
        numberFormatter.minimumFractionDigits = MLinearEquationsProjectRowItemCoefficient.kMinDecimals
        numberFormatter.maximumFractionDigits = MLinearEquationsProjectRowItemCoefficient.kMaxDecimals
        
        let coefficientDividend:Double = polynomial.coefficientDividend
        let coefficientDivisor:Double = polynomial.coefficientDivisor
        let coefficient:Double = coefficientDividend / coefficientDivisor
        let coefficientNumber:NSNumber = coefficient as NSNumber
        let reusableIdentifier:String = VLinearEquationsProjectCellCoefficientWhole.reusableIdentifier
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(
                size:MLinearEquationsProjectRowItemCoefficient.kFontSize)]
        let rawString:String? = numberFormatter.string(from:coefficientNumber)
        
        if let rawString:String = rawString
        {
            attributedString = NSAttributedString(
                string:rawString,
                attributes:attributes)
        }
        else
        {
            attributedString = NSAttributedString()
        }
        
        let maxSize:CGSize = CGSize(
            width:MLinearEquationsProjectRowItemCoefficient.kMaxWidth,
            height:MLinearEquationsProjectRowItemCoefficient.kMaxHeight)
        let stringRect:CGRect = attributedString.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let stringWidth:CGFloat = ceil(stringRect.size.width)
        let cellWidth:CGFloat = stringWidth + MLinearEquationsProjectRowItemCoefficient.kStringMargin
        
        super.init(
            polynomial:polynomial,
            cellWidth:cellWidth,
            reusableIdentifier:reusableIdentifier,
            column:column)
    }
}
