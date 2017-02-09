import UIKit

class MLinearEquationsSolutionEquationItemPolynomialDivision:MLinearEquationsSolutionEquationItemPolynomial
{
    init(
        indeterminate:DIndeterminate,
        coefficientDividend:Double,
        coefficientDivisor:Double)
    {
        let reusableIdentifier:String = VLinearEquationsSolutionCellPolynomialDivision.reusableIdentifier
        let cellWidth:CGFloat = 100
        
        super.init(
            indeterminate:indeterminate,
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
