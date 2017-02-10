import UIKit

class MLinearEquationsSolutionEquationItemConstantDecimal:MLinearEquationsSolutionEquationItemConstant
{
    let string:NSAttributedString
    private let kFontSize:CGFloat = 20
    private let kMaxStringWidth:CGFloat = 5000
    private let kMaxStringHeight:CGFloat = 30
    private let kAddedWidth:CGFloat = 30
    private let kShowAsDivision:Bool = false
    
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        index:Int,
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
        let rawString:String = MSession.sharedInstance.stringFrom(
            number:absoluteCoefficient)
        
        string = NSAttributedString(
            string:rawString,
            attributes:attributes)
        
        let stringRect:CGRect = string.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let textWidth:CGFloat = ceil(stringRect.size.width)
        let reusableIdentifier:String = VLinearEquationsSolutionCellConstantDecimal.reusableIdentifier
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
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            index:index,
            showSign:showSign,
            showAsDivision:kShowAsDivision,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
