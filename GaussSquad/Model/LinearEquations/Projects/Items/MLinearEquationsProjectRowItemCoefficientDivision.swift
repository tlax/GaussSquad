import UIKit

class MLinearEquationsProjectRowItemCoefficientDivision:MLinearEquationsProjectRowItemCoefficient
{
    let attributedStringDividend:NSAttributedString
    let attributedStringDivisor:NSAttributedString
    
    init(
        polynomial:DPolynomial,
        column:Int)
    {
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = MLinearEquationsProjectRowItemCoefficient.kNumberFormatterStyle
        numberFormatter.minimumIntegerDigits = MLinearEquationsProjectRowItemCoefficient.kMinIntegers
        numberFormatter.maximumIntegerDigits = MLinearEquationsProjectRowItemCoefficient.kMaxIntegers
        numberFormatter.minimumFractionDigits = MLinearEquationsProjectRowItemCoefficient.kMinDecimals
        numberFormatter.maximumFractionDigits = MLinearEquationsProjectRowItemCoefficient.kMaxDecimals
        
        let coefficientDividend:NSNumber = polynomial.coefficientDividend as NSNumber
        let coefficientDivisor:NSNumber = polynomial.coefficientDivisor as NSNumber
        let reusableIdentifier:String = VLinearEquationsProjectCellCoefficientDivision.reusableIdentifier
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(
                size:MLinearEquationsProjectRowItemCoefficient.kFontSize)]
        let maxSize:CGSize = CGSize(
            width:MLinearEquationsProjectRowItemCoefficient.kMaxWidth,
            height:MLinearEquationsProjectRowItemCoefficient.kMaxHeight)
        let rawStringDividend:String? = numberFormatter.string(from:coefficientDividend)
        let rawStringDivisor:String? = numberFormatter.string(from:coefficientDivisor)
        
        if let rawStringDividend:String = rawStringDividend
        {
            attributedStringDividend = NSAttributedString(
                string:rawStringDividend,
                attributes:attributes)
        }
        else
        {
            attributedStringDividend = NSAttributedString()
        }
        
        if let rawStringDivisor:String = rawStringDivisor
        {
            attributedStringDivisor = NSAttributedString(
                string:rawStringDivisor,
                attributes:attributes)
        }
        else
        {
            attributedStringDivisor = NSAttributedString()
        }
        
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
        let cellWidth:CGFloat = stringWidth + MLinearEquationsProjectRowItemCoefficient.kStringMargin
        
        super.init(
            polynomial:polynomial,
            cellWidth:cellWidth,
            reusableIdentifier:reusableIdentifier,
            column:column)
    }
}
