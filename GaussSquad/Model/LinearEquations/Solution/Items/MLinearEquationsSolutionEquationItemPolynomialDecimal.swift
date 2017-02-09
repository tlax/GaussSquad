import UIKit

class MLinearEquationsSolutionEquationItemPolynomialDecimal:MLinearEquationsSolutionEquationItemPolynomial
{
    let stringCoefficient:NSAttributedString
    private let kFontSize:CGFloat = 20
    private let kMaxStringWidth:CGFloat = 5000
    private let kMaxStringHeight:CGFloat = 30
    
    init(
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        coefficientDividend:Double,
        coefficientDivisor:Double)
    {
        let reusableIdentifier:String = VLinearEquationsSolutionCellPolynomialDecimal.reusableIdentifier
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:kFontSize)]
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let maxSize:CGSize = CGSize(
            width:kMaxStringWidth,
            height:kMaxStringHeight)
        let coefficient:Double = coefficientDividend / coefficientDivisor
        let rawString:String = MSession.sharedInstance.stringFrom(
            number:coefficient)
        
        let attributedCoefficient:NSAttributedString = NSAttributedString(
            string:rawString,
            attributes:attributes)
        let attributedIndeterminate:NSAttributedString = NSAttributedString(
            string:indeterminate.symbol,
            attributes:attributes)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(attributedCoefficient)
        mutableString.append(attributedIndeterminate)
        stringCoefficient = mutableString
        
        let stringRect:CGRect = stringCoefficient.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let cellWidth:CGFloat = ceil(stringRect.size.width)
        
        super.init(
            indeterminate:indeterminate,
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
