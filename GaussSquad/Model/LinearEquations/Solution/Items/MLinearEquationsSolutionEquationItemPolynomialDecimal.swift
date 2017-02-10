import UIKit

class MLinearEquationsSolutionEquationItemPolynomialDecimal:MLinearEquationsSolutionEquationItemPolynomial
{
    let string:NSAttributedString
    private let kFontSize:CGFloat = 20
    private let kMaxStringWidth:CGFloat = 5000
    private let kMaxStringHeight:CGFloat = 30
    private let kAddedWidth:CGFloat = 20
    
    init(
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool)
    {
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:kFontSize)]
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let maxSize:CGSize = CGSize(
            width:kMaxStringWidth,
            height:kMaxStringHeight)
        let coefficient:Double = coefficientDividend / coefficientDivisor
        let attributedIndeterminate:NSAttributedString = NSAttributedString(
            string:indeterminate.symbol,
            attributes:attributes)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if coefficient != 1
        {
            let absoluteCoefficient:Double = abs(coefficient)
            let rawString:String = MSession.sharedInstance.stringFrom(
                number:absoluteCoefficient)
            let attributedCoefficient:NSAttributedString = NSAttributedString(
                string:rawString,
                attributes:attributes)
            mutableString.append(attributedCoefficient)
        }
        
        mutableString.append(attributedIndeterminate)
        string = mutableString
        
        let stringRect:CGRect = string.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let textWidth:CGFloat = ceil(stringRect.size.width)
        let reusableIdentifier:String = VLinearEquationsSolutionCellPolynomialDecimal.reusableIdentifier
        let cellWidth:CGFloat
        
        if showSign
        {
            cellWidth = textWidth + kAddedWidth
        }
        else
        {
            cellWidth = textWidth
        }
        
        super.init(
            indeterminate:indeterminate,
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            showSign:showSign,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
