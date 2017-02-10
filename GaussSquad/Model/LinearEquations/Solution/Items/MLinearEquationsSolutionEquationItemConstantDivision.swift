import UIKit

class MLinearEquationsSolutionEquationItemConstantDivision:MLinearEquationsSolutionEquationItemConstant
{
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool)
    {
        let reusableIdentifier:String = VLinearEquationsSolutionCellConstantDivision.reusableIdentifier
        let cellWidth:CGFloat = 100
        
        super.init(
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            showSign:showSign,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
