import UIKit

class MLinearEquationsSolutionStepStart:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 60
    
    init(equations:[MLinearEquationsSolutionEquation])
    {
        let reusableIdentifier:String = VLinearEquationsSolutionHeaderStart.reusableIdentifier
        
        super.init(
            equations:equations,
            reusableIdentifier:reusableIdentifier,
            headerHeight:kHeaderHeight)
    }
}
