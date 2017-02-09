import UIKit

class MLinearEquationsSolutionEquationItemConstantDivision:MLinearEquationsSolutionEquationItemConstant
{
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double)
    {
        let reusableIdentifier:String = VLinearEquationsSolutionCellConstantDivision.reusableIdentifier
        let cellWidth:CGFloat = 100
        
        super.init(
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
