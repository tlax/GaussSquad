import UIKit

class MLinearEquationsSolutionEquationItemConstant:MLinearEquationsSolutionEquationItem
{
    let coefficientDividend:Double
    let coefficientDivisor:Double
    let index:Int
    let showSign:Bool
    let showAsDivision:Bool
    
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        index:Int,
        showSign:Bool,
        showAsDivision:Bool,
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.coefficientDividend = coefficientDividend
        self.coefficientDivisor = coefficientDivisor
        self.index = index
        self.showSign = showSign
        self.showAsDivision = showAsDivision
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
