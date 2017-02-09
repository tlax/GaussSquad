import UIKit

class MLinearEquationsSolutionEquationItemPolynomial:MLinearEquationsSolutionEquationItem
{
    weak var indeterminate:DIndeterminate!
    let coefficientDividend:Double
    let coefficientDivisor:Double
    
    init(
        indeterminate:DIndeterminate,
        coefficientDividend:Double,
        coefficientDivisor:Double,
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.indeterminate = indeterminate
        self.coefficientDividend = coefficientDividend
        self.coefficientDivisor = coefficientDivisor
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
