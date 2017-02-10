import UIKit

class MLinearEquationsSolutionEquationItemPolynomialDivision:MLinearEquationsSolutionEquationItemPolynomial
{
    init(
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool)
    {
        let reusableIdentifier:String = VLinearEquationsSolutionCellPolynomialDivision.reusableIdentifier
        let cellWidth:CGFloat = 100
        
        super.init(
            indeterminate:indeterminate,
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            showSign:showSign,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
