import UIKit

class MLinearEquationsProjectRowItemPolynomialDivision:MLinearEquationsProjectRowItemPolynomial
{
    let attributedDividend:NSAttributedString
    let attributedDivisor:NSAttributedString
    let positive:Bool
    private let kFontSize:CGFloat = 19
    private let kMaxHeight:CGFloat = 25
    private let kMaxWidth:CGFloat = 5000
    private let kMargin:CGFloat = 30
    
    init(polynomial:DPolynomial)
    {
        positive = polynomial.isPositive
        
        let coefficientDividend:Double = polynomial.coefficientDividend
        let coefficientDivisor:Double = polynomial.coefficientDivisor
        let reusableIdentifier:String = VLinearEquationsProjectCellPolynomialDivision.reusableIdentifier
        let drawingOptions:NSStringDrawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(
                size:kFontSize)]
        
        let mutableDividend:NSMutableAttributedString = NSMutableAttributedString()
        let rawDividend:String = MSession.sharedInstance.stringFrom(
            number:coefficientDividend)
        let stringDividend:NSAttributedString = NSAttributedString(
            string:rawDividend,
            attributes:attributes)
        mutableDividend.append(stringDividend)
        
        if let rawSymbol:String = polynomial.indeterminate?.symbol
        {
            let stringSymbol:NSAttributedString = NSAttributedString(
                string:rawSymbol,
                attributes:attributes)
            mutableDividend.append(stringSymbol)
        }
        
        attributedDividend = mutableDividend
        
        let rawDivisor:String = MSession.sharedInstance.stringFrom(
            number:coefficientDivisor)
        attributedDivisor = NSAttributedString(
            string:rawDivisor,
            attributes:attributes)
        
        let maxSize:CGSize = CGSize(
            width:kMaxWidth,
            height:kMaxHeight)
        
        let rectDividend:CGRect = attributedDividend.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        let rectDivisor:CGRect = attributedDivisor.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        
        let widthDividend:CGFloat = ceil(rectDividend.size.width)
        let widthDivisor:CGFloat = ceil(rectDivisor.size.width)
        
        let widthDivision:CGFloat = max(widthDividend, widthDivisor)
        let totalWidth:CGFloat = widthDivision + kMargin
        
        super.init(
            polynomial:polynomial,
            cellWidth:totalWidth,
            reusableIdentifier:reusableIdentifier)
    }
}
