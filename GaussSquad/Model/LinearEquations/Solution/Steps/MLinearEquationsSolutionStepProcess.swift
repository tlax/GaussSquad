import UIKit

class MLinearEquationsSolutionStepProcess:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 150
    
    init(equations:[MLinearEquationsSolutionEquation])
    {
        let reusableIdentifier:String = VLinearEquationsSolutionHeaderProcess.reusableIdentifier
        
        super.init(
            equations:equations,
            reusableIdentifier:reusableIdentifier,
            headerHeight:kHeaderHeight)
    }
}
