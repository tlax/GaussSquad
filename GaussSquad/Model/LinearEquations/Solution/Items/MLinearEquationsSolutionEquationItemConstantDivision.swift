import UIKit

class MLinearEquationsSolutionEquationItemConstantDivision:MLinearEquationsSolutionEquationItemConstant
{
    let stringDividend:NSAttributedString
    let stringDivisor:NSAttributedString
    private let kFontSize:CGFloat = 20
    private let kMaxStringWidth:CGFloat = 5000
    private let kMaxStringHeight:CGFloat = 20
    private let kAddedWidth:CGFloat = 30
    private let kShowAsDivision:Bool = true
    
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        index:Int,
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
        let rawStringDividend:String = MSession.sharedInstance.stringFrom(
            number:absoluteDividend)
        let rawStringDivisor:String = MSession.sharedInstance.stringFrom(
            number:coefficientDivisor)
        stringDividend = NSAttributedString(
            string:rawStringDividend,
            attributes:attributes)
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
        
        let reusableIdentifier:String = VLinearEquationsSolutionCellConstantDivision.reusableIdentifier
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
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            index:index,
            showSign:showSign,
            showAsDivision:kShowAsDivision,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
