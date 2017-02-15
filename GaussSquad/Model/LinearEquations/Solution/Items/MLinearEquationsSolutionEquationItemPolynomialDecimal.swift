import UIKit

class MLinearEquationsSolutionEquationItemPolynomialDecimal:MLinearEquationsSolutionEquationItemPolynomial
{
    let string:NSAttributedString
    let stringSign:String
    let signWidth:CGFloat
    let imageSign:UIImage?
    private let kMaxSignWidth:CGFloat = 20
    private let kFontSize:CGFloat = 20
    private let kMaxStringWidth:CGFloat = 5000
    private let kMaxStringHeight:CGFloat = 30
    private let kShowAsDivision:Bool = false
    private let kAdd:String = "+"
    private let kSubstract:String = "-"
    private let kEmpty:String = ""
    
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
        let absoluteCoefficient:Double = abs(coefficient)
        let attributedIndeterminate:NSAttributedString = NSAttributedString(
            string:indeterminate.symbol,
            attributes:attributes)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if absoluteCoefficient != 1
        {
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
        
        if showSign
        {
            signWidth = kMaxSignWidth
            
            if coefficientDividend >= 0
            {
                imageSign = #imageLiteral(resourceName: "assetGenericColAddSmall")
                stringSign = kAdd
            }
            else
            {
                imageSign = #imageLiteral(resourceName: "assetGenericColSubstractSmall")
                stringSign = kSubstract
            }
        }
        else
        {
            signWidth = 0
            imageSign = nil
            stringSign = kEmpty
        }
        
        let cellWidth:CGFloat = textWidth + signWidth
        
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
        mutableString.append(stringSign)
        mutableString.append(self.string.string)
        
        let string:String = mutableString as String
        
        return string
    }
}
