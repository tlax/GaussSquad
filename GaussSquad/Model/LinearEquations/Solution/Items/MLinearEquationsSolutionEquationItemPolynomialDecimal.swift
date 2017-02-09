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
        stringCoefficient = NSAttributedString(
            string:"",
            attributes:attributes)
        
        let cellWidth:CGFloat = 100
        
        super.init(
            indeterminate:indeterminate,
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
