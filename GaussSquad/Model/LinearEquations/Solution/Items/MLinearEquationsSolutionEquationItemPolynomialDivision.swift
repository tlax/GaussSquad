import UIKit

class MLinearEquationsSolutionEquationItemPolynomialDivision:MLinearEquationsSolutionEquationItemPolynomial
{
    let stringDividend:NSAttributedString
    let stringDivisor:NSAttributedString
    private let kFontSize:CGFloat = 17
    private let kMaxStringWidth:CGFloat = 5000
    private let kMaxStringHeight:CGFloat = 20
    private let kAddedWidth:CGFloat = 20
    private let kShowAsDivision:Bool = true
    private let kAdd:String = "+"
    private let kSubstract:String = "-"
    private let kDivision:String = "/"
    
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
            showAsDivision:kShowAsDivision,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
    
    override func shareText() -> String?
    {
        let mutableString:NSMutableString = NSMutableString()
        
        if showSign
        {
            if coefficient >= 0
            {
                mutableString.append(kAdd)
            }
            else
            {
                mutableString.append(kSubstract)
            }
        }
        
        mutableString.append(stringDividend.string)
        mutableString.append(kDivision)
        mutableString.append(stringDivisor.string)
        
        let string:String = mutableString as String
        
        return string
    }
}
