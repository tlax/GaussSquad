import UIKit

class MLinearEquationsSolutionEquationItemPolynomialDecimal:MLinearEquationsSolutionEquationItemPolynomial
{
    init(
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        coefficientDividend:Double,
        coefficientDivisor:Double)
    {
        let reusableIdentifier:String = VLinearEquationsSolutionCellPolynomialDecimal.reusableIdentifier
        let cellWidth:CGFloat = 100
        
        super.init(
            indeterminate:indeterminate,
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
