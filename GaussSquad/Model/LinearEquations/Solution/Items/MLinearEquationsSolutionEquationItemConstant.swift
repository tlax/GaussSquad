import UIKit

class MLinearEquationsSolutionEquationItemConstant:MLinearEquationsSolutionEquationItem
{
    let coefficientDividend:Double
    let coefficientDivisor:Double
    
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.coefficientDividend = coefficientDividend
        self.coefficientDivisor = coefficientDivisor
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
