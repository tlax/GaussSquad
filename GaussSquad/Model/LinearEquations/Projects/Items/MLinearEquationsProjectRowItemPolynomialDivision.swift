import UIKit

class MLinearEquationsProjectRowItemPolynomialDivision:MLinearEquationsProjectRowItemPolynomial
{
    let attributedDividend:NSAttributedString
    let attributedDivisor:NSAttributedString
    let attributedSymbol:NSAttributedString
    let widthDivision:CGFloat
    private let kNumberFormatterStyle:NumberFormatter.Style = NumberFormatter.Style.decimal
    private let kFontSize:CGFloat = 30
    private let kMaxHeight:CGFloat = 30
    private let kMaxWidth:CGFloat = 5000
    private let kMargin:CGFloat = 25
    private let kMinIntegers:Int = 1
    private let kMaxIntegers:Int = 32
    private let kMinDecimals:Int = 0
    private let kMaxDecimals:Int = 32
    
    init(polynomial:DPolynomial)
    {
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = kNumberFormatterStyle
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumIntegerDigits = kMaxIntegers
        numberFormatter.minimumFractionDigits = kMinDecimals
        numberFormatter.maximumFractionDigits = kMaxDecimals
        
        let coefficientDividend:NSNumber = NSNumber(value:polynomial.coefficientDividend)
        let coefficientDivisor:NSNumber = NSNumber(value:polynomial.coefficientDivisor)
        let reusableIdentifier:String = VLinearEquationsProjectCellPolynomialDivision.reusableIdentifier
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(
                size:kFontSize)]
        
        if let rawDividend:String = numberFormatter.string(from:coefficientDividend)
        {
            attributedDividend = NSAttributedString(
                string:rawDividend,
                attributes:attributes)
        }
        else
        {
            attributedDividend = NSAttributedString()
        }
        
        if let rawDivisor:String = numberFormatter.string(from:coefficientDivisor)
        {
            attributedDivisor = NSAttributedString(
                string:rawDivisor,
                attributes:attributes)
        }
        else
        {
            attributedDivisor = NSAttributedString()
        }
        
        if let rawSymbol:String = polynomial.indeterminate?.symbol
        {
            attributedSymbol = NSAttributedString(
                string:rawSymbol,
                attributes:attributes)
        }
        else
        {
            attributedSymbol = NSAttributedString()
        }
        
        let maxSize:CGSize = CGSize(
            width:kMaxWidth,
            height:kMaxHeight)
        
        let rectDividend:CGRect = attributedDividend.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let rectDivisor:CGRect = attributedDividend.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let rectSymbol:CGRect = attributedDividend.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        
        let widthDividend:CGFloat = ceil(rectDividend.size.width)
        let widthDivisor:CGFloat = ceil(rectDivisor.size.width)
        let widthSymbol:CGFloat = ceil(rectSymbol.size.width)
        
        widthDivision = max(widthDividend, widthDivisor)
        let totalWidth:CGFloat = widthSymbol + widthDivision + kMargin
        
        super.init(
            polynomial:polynomial,
            cellWidth:totalWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
