import UIKit

class MLinearEquationsProjectRowItemPolynomialDecimal:MLinearEquationsProjectRowItemPolynomial
{
    let attributedString:NSAttributedString
    let positive:Bool
    private let kNumberFormatterStyle:NumberFormatter.Style = NumberFormatter.Style.decimal
    private let kFontSize:CGFloat = 25
    private let kMaxHeight:CGFloat = 30
    private let kMaxWidth:CGFloat = 5000
    private let kMargin:CGFloat = 45
    private let kMinIntegers:Int = 1
    private let kMaxIntegers:Int = 10
    private let kMinDecimals:Int = 0
    private let kMaxDecimals:Int = 10
    
    init(polynomial:DPolynomial)
    {
        positive = polynomial.isPositive
        
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = kNumberFormatterStyle
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumIntegerDigits = kMaxIntegers
        numberFormatter.minimumFractionDigits = kMinDecimals
        numberFormatter.maximumFractionDigits = kMaxDecimals
        
        let coefficientDividend:Double = polynomial.coefficientDividend
        let coefficientDivisor:Double = polynomial.coefficientDivisor
        let coefficient:Double = coefficientDividend / coefficientDivisor
        let coefficientNumber:NSNumber = coefficient as NSNumber
        let reusableIdentifier:String = VLinearEquationsProjectCellPolynomialDecimal.reusableIdentifier
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(
                size:kFontSize)]
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if let rawCoefficient:String = numberFormatter.string(from:coefficientNumber)
        {
            let stringCoefficient:NSAttributedString = NSAttributedString(
                string:rawCoefficient,
                attributes:attributes)
            mutableString.append(stringCoefficient)
        }
        
        if let rawSymbol:String = polynomial.indeterminate?.symbol
        {
            let stringSymbol:NSAttributedString = NSAttributedString(
                string:rawSymbol,
                attributes:attributes)
            mutableString.append(stringSymbol)
        }
        
        attributedString = mutableString
        
        let maxSize:CGSize = CGSize(
            width:kMaxWidth,
            height:kMaxHeight)
        let stringRect:CGRect = attributedString.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let stringWidth:CGFloat = ceil(stringRect.size.width)
        let cellWidth:CGFloat = stringWidth + kMargin
        
        super.init(
            polynomial:polynomial,
            cellWidth:cellWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
