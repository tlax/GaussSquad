import UIKit

class MLinearEquationsSolutionEquationItemConstant:MLinearEquationsSolutionEquationItem
{
    let coefficientDividend:Double
    let coefficientDivisor:Double
    let showSign:Bool
    
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool,
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.coefficientDividend = coefficientDividend
        self.coefficientDivisor = coefficientDivisor
        self.showSign = showSign
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
