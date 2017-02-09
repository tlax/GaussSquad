import UIKit

class MLinearEquationsSolutionEquationItem
{
    let coefficientDividend:Double
    let coefficientDivisor:Double
    let reusableIdentifier:String
    let cellWidth:CGFloat
    
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.coefficientDividend = coefficientDividend
        self.coefficientDivisor = coefficientDivisor
        self.reusableIdentifier = reusableIdentifier
        self.cellWidth = cellWidth
    }
}
