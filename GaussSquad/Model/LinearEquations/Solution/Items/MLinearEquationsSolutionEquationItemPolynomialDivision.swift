import UIKit

class MLinearEquationsSolutionEquationItemPolynomialDivision:MLinearEquationsSolutionEquationItemPolynomial
{
    let stringDividend:NSAttributedString
    let stringDivisor:NSAttributedString
    let stringSign:String
    let signWidth:CGFloat
    let imageSign:UIImage?
    let kBorderHeight:CGFloat = 1
    let kLabelHeight:CGFloat = 15
    private let drawingOptions:NSStringDrawingOptions
    private let kMaxSignWidth:CGFloat = 20
    private let kFontSize:CGFloat = 12
    private let kMaxStringWidth:CGFloat = 5000
    private let kMaxStringHeight:CGFloat = 20
    private let kShowAsDivision:Bool = true
    private let kAdd:String = "+"
    private let kSubstract:String = "-"
    private let kDivision:String = "/"
    private let kEmpty:String = ""
    
    init(
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool)
    {
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesLineFragmentOrigin,
            NSStringDrawingOptions.usesFontLeading])
        
        let absoluteDividend:Double = abs(coefficientDividend)
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numericBold(size:kFontSize)]
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
        
        let cellWidth:CGFloat = textMaxWidth + signWidth
        
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
        mutableString.append(stringDividend.string)
        mutableString.append(kDivision)
        mutableString.append(stringDivisor.string)
        
        let string:String = mutableString as String
        
        return string
    }
    
    override func drawInRect(rect:CGRect)
    {
        let rectX:CGFloat = rect.origin.x
        let rectY:CGFloat = rect.origin.y
        let rectWidth:CGFloat = rect.size.width
        let rectHeight:CGFloat = rect.size.height
        let rectHeight_2:CGFloat = rectHeight / 2.0
        let rectCenterY:CGFloat = rectY + rectHeight_2
        
        if let imageSign:UIImage = self.imageSign
        {
            let imageWidth:CGFloat = imageSign.size.width
            let imageHeight:CGFloat = imageSign.size.height
            let imageRemainX:CGFloat = signWidth - imageWidth
            let imageRemainY:CGFloat = rectHeight - imageHeight
            let imageMarginX:CGFloat = imageRemainX / 2.0
            let imageMarginY:CGFloat = imageRemainY / 2.0
            let imageRect:CGRect = CGRect(
                x:rectX + imageMarginX,
                y:rectY + imageMarginY,
                width:imageWidth,
                height:imageHeight)
            
            imageSign.draw(in:imageRect)
        }
        
        let stringPossibleWidth:CGFloat = rectWidth - signWidth
        let dividendRect:CGRect = stringDividend.boundingRect(
            with:rect.size,
            options:drawingOptions,
            context:nil)
        let maxDividendWidth:CGFloat = ceil(dividendRect.width)
        let dividendRemainWidth:CGFloat = stringPossibleWidth - maxDividendWidth
        let dividendMarginLeft:CGFloat = dividendRemainWidth / 2.0
        let stringDividendTop:CGFloat = (rectCenterY + kBorderHeight) - kLabelHeight
        let stringDividendLeft:CGFloat = rectX + dividendMarginLeft + signWidth
        let stringDividendRect:CGRect = CGRect(
            x:stringDividendLeft,
            y:stringDividendTop,
            width:maxDividendWidth,
            height:kLabelHeight)
        
        stringDividend.draw(in:stringDividendRect)
        
        let divisorRect:CGRect = stringDivisor.boundingRect(
            with:rect.size,
            options:drawingOptions,
            context:nil)
        let maxDivisorWidth:CGFloat = ceil(divisorRect.width)
        let divisorRemainWidth:CGFloat = stringPossibleWidth - maxDivisorWidth
        let divisorMarginLeft:CGFloat = divisorRemainWidth / 2.0
        let stringDivisorTop:CGFloat = rectCenterY - kBorderHeight
        let stringDivisorLeft:CGFloat = rectX + divisorMarginLeft + signWidth
        let stringDivisorRect:CGRect = CGRect(
            x:stringDivisorLeft,
            y:stringDivisorTop,
            width:maxDivisorWidth,
            height:kLabelHeight)
        
        stringDivisor.draw(in:stringDivisorRect)
        
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
            
        else
        {            
            return
        }
        
        let borderLeft:CGFloat = rectX + signWidth
        let borderWidth:CGFloat = rectWidth - signWidth
        let borderRemain:CGFloat = rectHeight - kBorderHeight
        let borderTop:CGFloat = borderRemain / 2.0
        let borderRect:CGRect = CGRect(
            x:borderLeft,
            y:borderTop + rectY,
            width:borderWidth,
            height:kBorderHeight)
        
        context.setFillColor(UIColor(white:0, alpha:0.3).cgColor)
        context.fill(borderRect)
    }
}
