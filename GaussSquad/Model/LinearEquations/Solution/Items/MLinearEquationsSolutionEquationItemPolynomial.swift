import UIKit

class MLinearEquationsSolutionEquationItemPolynomial:MLinearEquationsSolutionEquationItem
{
    weak var indeterminate:MLinearEquationsSolutionIndeterminatesItem!
    let coefficientDividend:Double
    let coefficientDivisor:Double
    let showSign:Bool
    let showAsDivision:Bool
    
    init(
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool,
        showAsDivision:Bool,
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.indeterminate = indeterminate
        self.coefficientDividend = coefficientDividend
        self.coefficientDivisor = coefficientDivisor
        self.showSign = showSign
        self.showAsDivision = showAsDivision
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
