import UIKit

class MLinearEquationsSolutionEquationItemPolynomial:MLinearEquationsSolutionEquationItem
{
    weak var indeterminate:MLinearEquationsSolutionIndeterminatesItem!
    let coefficientDividend:Double
    let coefficientDivisor:Double
    let showSign:Bool
    
    init(
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool,
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.indeterminate = indeterminate
        self.coefficientDividend = coefficientDividend
        self.coefficientDivisor = coefficientDivisor
        self.showSign = showSign
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
