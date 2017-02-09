import UIKit

class MLinearEquationsProjectRowItemPolynomialDecimal:MLinearEquationsProjectRowItemPolynomial
{
    let attributedString:NSAttributedString
    let positive:Bool
    private let kFontSize:CGFloat = 32
    private let kMaxHeight:CGFloat = 30
    private let kMaxWidth:CGFloat = 5000
    private let kMargin:CGFloat = 30
    
    init(polynomial:DPolynomial)
    {
        positive = polynomial.isPositive
        
        let coefficient:Double = abs(polynomial.coefficient())
        let coefficientNumber:NSNumber = NSNumber(value:coefficient)
        let reusableIdentifier:String = VLinearEquationsProjectCellPolynomialDecimal.reusableIdentifier
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(
                size:kFontSize)]
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if let rawCoefficient:String = MSession.sharedInstance.numberFormatter.string(from:coefficientNumber)
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
