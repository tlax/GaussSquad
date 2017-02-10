import UIKit

class MLinearEquationsSolutionEquationItemConstantDecimal:MLinearEquationsSolutionEquationItemConstant
{
    init(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        showSign:Bool)
    {
        let reusableIdentifier:String = VLinearEquationsSolutionCellConstantDecimal.reusableIdentifier
        let cellWidth:CGFloat = 100
        
        super.init(
            coefficientDividend:coefficientDividend,
            coefficientDivisor:coefficientDivisor,
            showSign:showSign,
            reusableIdentifier:reusableIdentifier,
            cellWidth:cellWidth)
    }
}
