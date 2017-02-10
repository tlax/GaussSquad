import UIKit

class MLinearEquationsSolutionEquationItemPolynomialDivision:MLinearEquationsSolutionEquationItemPolynomial
{
    let stringDividend:NSAttributedString
    let stringDivisor:NSAttributedString
    private let kFontSize:CGFloat = 20
    private let kMaxStringWidth:CGFloat = 5000
    private let kMaxStringHeight:CGFloat = 20
    private let kAddedWidth:CGFloat = 30
    
    init(
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool)
    {
        let absoluteDividend:Double = abs(coefficientDividend)
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:kFontSize)]
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let maxSize:CGSize = CGSize(
            width:kMaxStringWidth,
            height:kMaxStringHeight)
        let rawStringDivisor:String = MSession.sharedInstance.stringFrom(
            number:coefficientDivisor)
        let attributedIndeterminate:NSAttributedString = NSAttributedString(
            string:indeterminate.symbol,
            attributes:attributes)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if absoluteDividend != 1
        {
            let rawStringDividend:String = MSession.sharedInstance.stringFrom(
                number:absoluteDividend)
            let attributedDividend:NSAttributedString = NSAttributedString(
                string:rawStringDividend,
                attributes:attributes)
            mutableString.append(attributedDividend)
        }
        
        mutableString.append(attributedIndeterminate)
        stringDividend = mutableString
        
        stringDivisor = NSAttributedString(
            string:rawStringDivisor,
            attributes:attributes)
        
        let stringDividendRect:CGRect = stringDividend.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let stringDivisorRect:CGRect = stringDivisor.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        
        let textDividendWidth:CGFloat = ceil(stringDividendRect.size.width)
        let textDivisorWidth:CGFloat = ceil(stringDivisorRect.size.width)
        let textMaxWidth:CGFloat = max(textDividendWidth, textDivisorWidth)
        
        let reusableIdentifier:String = VLinearEquationsSolutionCellPolynomialDivision.reusableIdentifier
        let cellWidth:CGFloat
        
        if showSign
        {
            cellWidth = textMaxWidth + kAddedWidth
        }
        else
        {
            cellWidth = textMaxWidth
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
